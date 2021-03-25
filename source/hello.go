/*
 * Project: etcd
 * Issue or PR  : https://github.com/coreos/etcd/pull/7902
 * Buggy version: dfdaf082c51ba14861267f632f6af795a27eb4ef
 * fix commit-id: 87d99fe0387ee1df1cf1811d88d37331939ef4ae
 * Flaky: 100/100
 * Description:
 *   At least two goroutines are needed to trigger this bug,
 * one is leader and the other is follower. Both the leader
 * and the follower execute the code above. If the follower
 * acquires mu.Lock() firstly and enter rc.release(), it will
 * be blocked at <- rcNextc (nextc). Only the leader can execute
 * close(nextc) to unblock the follower inside rc.release().
 * However, in order to invoke rc.release(), the leader needs
 * to acquires mu.Lock().
 *   The fix is to remove the lock and unlock around rc.release().
 */
package etcd7902

import (
	"sync"
	"time"
)

type roundClient struct {
	progress int
	acquire  func()
	validate func()
	release  func()
}

type Mu struct {
	mu *sync.Mutex
}

func doRounds(rcs []roundClient, rounds int) {
	var mu Mu
	var wg sync.WaitGroup
	wg.Add(len(rcs))
	for i := range rcs {
		go func(rc *roundClient) { // G2,G3
			defer wg.Done()
			for rc.progress < rounds || rounds <= 0 {
				rc.acquire()
				mu.mu.Lock()
				rc.validate()
				mu.mu.Unlock()
				time.Sleep(10 * time.Millisecond)
				rc.progress++
				mu.mu.Lock() // Leader is blocking here
				rc.release()
				mu.mu.Unlock()
			}
		}(&rcs[i])
	}
	wg.Wait()
}

///
/// G1						G2 (leader)					G3 (follower)
/// runElectionFunc()
/// doRounds()
/// wg.Wait()
/// 						...
/// 						mu.Lock()
/// 						rc.validate()
/// 						rcNextc = nextc
/// 						mu.Unlock()					...
/// 													mu.Lock()
/// 													rc.validate()
/// 													mu.Unlock()
/// 													mu.Lock()
/// 													rc.release()
/// 													<-rcNextc
/// 						mu.Lock()
/// -------------------------G1,G2,G3 deadlock--------------------------
///
