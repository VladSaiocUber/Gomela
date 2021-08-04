// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/ethereum/go-ethereum/blob/b8040a430e34117f121c67e8deee4a5e889e8372/light/lightchain_test.go#L297
#define not_found_416  -2 // opt events line 358
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_testReorg2970 = [1] of {int};
	run testReorg297(child_testReorg2970);
	run receiver(child_testReorg2970)
stop_process:skip
}

proctype testReorg297(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetTdByHash4355 = [1] of {int};
	chan child_GetHeaderByNumber4904 = [1] of {int};
	chan child_GetHeaderByNumber4903 = [1] of {int};
	chan child_CurrentHeader4232 = [1] of {int};
	chan child_InsertHeaderChain3831 = [1] of {int};
	chan child_InsertHeaderChain3830 = [1] of {int};
	Wgdef bc_wg;
	Mutexdef bc_chainmu;
	Mutexdef bc_blockCache_lock;
	Mutexdef bc_bodyRLPCache_lock;
	Mutexdef bc_bodyCache_lock;
	Mutexdef bc_scope_mu;
	Mutexdef bc_chainHeadFeed_mu;
	Mutexdef bc_chainSideFeed_mu;
	Mutexdef bc_chainFeed_mu;
	run mutexMonitor(bc_chainFeed_mu);
	run mutexMonitor(bc_chainSideFeed_mu);
	run mutexMonitor(bc_chainHeadFeed_mu);
	run mutexMonitor(bc_scope_mu);
	run mutexMonitor(bc_bodyCache_lock);
	run mutexMonitor(bc_bodyRLPCache_lock);
	run mutexMonitor(bc_blockCache_lock);
	run mutexMonitor(bc_chainmu);
	run wgMonitor(bc_wg);
	run InsertHeaderChain383(bc_wg,bc_blockCache_lock,bc_bodyCache_lock,bc_bodyRLPCache_lock,bc_chainFeed_mu,bc_chainHeadFeed_mu,bc_chainmu,bc_chainSideFeed_mu,bc_scope_mu,child_InsertHeaderChain3830);
	child_InsertHeaderChain3830?0;
	run InsertHeaderChain383(bc_wg,bc_blockCache_lock,bc_bodyCache_lock,bc_bodyRLPCache_lock,bc_chainFeed_mu,bc_chainHeadFeed_mu,bc_chainmu,bc_chainSideFeed_mu,bc_scope_mu,child_InsertHeaderChain3831);
	child_InsertHeaderChain3831?0;
	run CurrentHeader423(bc_wg,bc_blockCache_lock,bc_bodyCache_lock,bc_bodyRLPCache_lock,bc_chainFeed_mu,bc_chainHeadFeed_mu,bc_chainmu,bc_chainSideFeed_mu,bc_scope_mu,child_CurrentHeader4232);
	child_CurrentHeader4232?0;
	run GetHeaderByNumber490(bc_wg,bc_blockCache_lock,bc_bodyCache_lock,bc_bodyRLPCache_lock,bc_chainFeed_mu,bc_chainHeadFeed_mu,bc_chainmu,bc_chainSideFeed_mu,bc_scope_mu,child_GetHeaderByNumber4903);
	child_GetHeaderByNumber4903?0;
	run GetHeaderByNumber490(bc_wg,bc_blockCache_lock,bc_bodyCache_lock,bc_bodyRLPCache_lock,bc_chainFeed_mu,bc_chainHeadFeed_mu,bc_chainmu,bc_chainSideFeed_mu,bc_scope_mu,child_GetHeaderByNumber4904);
	child_GetHeaderByNumber4904?0;
	run GetTdByHash435(bc_wg,bc_blockCache_lock,bc_bodyCache_lock,bc_bodyRLPCache_lock,bc_chainFeed_mu,bc_chainHeadFeed_mu,bc_chainmu,bc_chainSideFeed_mu,bc_scope_mu,child_GetTdByHash4355);
	child_GetTdByHash4355?0;
	stop_process: skip;
	child!0
}
proctype InsertHeaderChain383(Wgdef lc_wg;Mutexdef lc_blockCache_lock;Mutexdef lc_bodyCache_lock;Mutexdef lc_bodyRLPCache_lock;Mutexdef lc_chainFeed_mu;Mutexdef lc_chainHeadFeed_mu;Mutexdef lc_chainmu;Mutexdef lc_chainSideFeed_mu;Mutexdef lc_scope_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_postChainEvents3580 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	lc_chainmu.Lock!false;
	lc_wg.update!1;
	

	if
	:: true -> 
		goto defer2
	:: true;
	fi;
	

	if
	:: true;
	:: true;
	fi;
	run postChainEvents358(lc_wg,lc_blockCache_lock,lc_bodyCache_lock,lc_bodyRLPCache_lock,lc_chainFeed_mu,lc_chainHeadFeed_mu,lc_chainmu,lc_chainSideFeed_mu,lc_scope_mu,not_found_416,child_postChainEvents3580);
	child_postChainEvents3580?0;
	goto defer2;
		defer2: skip;
	lc_wg.update!-1;
		defer1: skip;
	lc_chainmu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype postChainEvents358(Wgdef lc_wg;Mutexdef lc_blockCache_lock;Mutexdef lc_bodyCache_lock;Mutexdef lc_bodyRLPCache_lock;Mutexdef lc_chainFeed_mu;Mutexdef lc_chainHeadFeed_mu;Mutexdef lc_chainmu;Mutexdef lc_chainSideFeed_mu;Mutexdef lc_scope_mu;int var_events;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype CurrentHeader423(Wgdef lc_wg;Mutexdef lc_blockCache_lock;Mutexdef lc_bodyCache_lock;Mutexdef lc_bodyRLPCache_lock;Mutexdef lc_chainFeed_mu;Mutexdef lc_chainHeadFeed_mu;Mutexdef lc_chainmu;Mutexdef lc_chainSideFeed_mu;Mutexdef lc_scope_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype GetHeaderByNumber490(Wgdef lc_wg;Mutexdef lc_blockCache_lock;Mutexdef lc_bodyCache_lock;Mutexdef lc_bodyRLPCache_lock;Mutexdef lc_chainFeed_mu;Mutexdef lc_chainHeadFeed_mu;Mutexdef lc_chainmu;Mutexdef lc_chainSideFeed_mu;Mutexdef lc_scope_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype GetTdByHash435(Wgdef lc_wg;Mutexdef lc_blockCache_lock;Mutexdef lc_bodyCache_lock;Mutexdef lc_bodyRLPCache_lock;Mutexdef lc_chainFeed_mu;Mutexdef lc_chainHeadFeed_mu;Mutexdef lc_chainmu;Mutexdef lc_chainSideFeed_mu;Mutexdef lc_scope_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

proctype mutexMonitor(Mutexdef m) {
bool locked = false;
do
:: true ->
	if
	:: m.Counter > 0 ->
		if 
		:: m.RUnlock?false -> 
			m.Counter = m.Counter - 1;
		:: m.RLock?false -> 
			m.Counter = m.Counter + 1;
		fi;
	:: locked ->
		m.Unlock?false;
		locked = false;
	:: else ->	 end:	if
		:: m.Unlock?false ->
			assert(0==32);		:: m.Lock?false ->
			locked =true;
		:: m.RUnlock?false ->
			assert(0==32);		:: m.RLock?false ->
			m.Counter = m.Counter + 1;
		fi;
	fi;
od
}

proctype receiver(chan c) {
c?0
}

