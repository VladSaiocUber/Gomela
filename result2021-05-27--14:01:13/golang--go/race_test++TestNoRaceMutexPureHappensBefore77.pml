// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/runtime/race/testdata/mutex_test.go#L77
#define ub_for93_3  -2
typedef Chandef {
	chan sync = [0] of {bool};
	chan enq = [0] of {int};
	chan deq = [0] of {bool,int};
	chan sending = [0] of {bool};
	chan rcving = [0] of {bool};
	chan closing = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestNoRaceMutexPureHappensBefore770 = [1] of {int};
	run TestNoRaceMutexPureHappensBefore77(child_TestNoRaceMutexPureHappensBefore770);
	run receiver(child_TestNoRaceMutexPureHappensBefore770)
stop_process:skip
}

proctype TestNoRaceMutexPureHappensBefore77(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestNoRaceMutexPureHappensBefore90821 = [1] of {int};
	chan child_AnonymousTestNoRaceMutexPureHappensBefore83820 = [1] of {int};
	Chandef ch;
	Mutexdef mu;
	run mutexMonitor(mu);
	

	if
	:: 2 > 0 -> 
		ch.size = 2;
		run AsyncChan(ch)
	:: else -> 
		run sync_monitor(ch)
	fi;
	run AnonymousTestNoRaceMutexPureHappensBefore8382(ch,mu,child_AnonymousTestNoRaceMutexPureHappensBefore83820);
	run receiver(child_AnonymousTestNoRaceMutexPureHappensBefore83820);
	run AnonymousTestNoRaceMutexPureHappensBefore9082(ch,mu,child_AnonymousTestNoRaceMutexPureHappensBefore90821);
	run receiver(child_AnonymousTestNoRaceMutexPureHappensBefore90821);
	

	if
	:: ch.deq?state,num_msgs;
	:: ch.sync?state -> 
		ch.rcving!false
	fi;
	

	if
	:: ch.deq?state,num_msgs;
	:: ch.sync?state -> 
		ch.rcving!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousTestNoRaceMutexPureHappensBefore8382(Chandef ch;Mutexdef mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	mu.Lock!false;
	mu.Unlock!false;
	

	if
	:: ch.enq!0;
	:: ch.sync!false -> 
		ch.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousTestNoRaceMutexPureHappensBefore9082(Chandef ch;Mutexdef mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	mu.Lock!false;
	

	if
	:: 0 != -2 && ub_for93_3 != -2 -> 
				for(i : 0.. ub_for93_3) {
			for11: skip;
			mu.Unlock!false;
			mu.Lock!false;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			mu.Unlock!false;
			mu.Lock!false;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	mu.Unlock!false;
	

	if
	:: ch.enq!0;
	:: ch.sync!false -> 
		ch.sending!false
	fi;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype AsyncChan(Chandef ch) {
do
:: true ->
if
:: ch.closed -> 
end: if
  :: ch.num_msgs > 0 -> // cannot send on closed channel
    end4: if
    :: ch.enq?0-> // cannot send on closed channel
      assert(1 == 0)
    :: ch.closing?true -> // cannot close twice a channel
      assert(2 == 0)
    :: ch.rcving?false;
    :: ch.sending?false -> // sending state of channel (closed)
      assert(1 == 0)
    :: ch.deq!true,ch.num_msgs -> 
  		 ch.num_msgs = ch.num_msgs - 1
    fi;
  :: else ->    end5: if
    :: ch.enq?0-> // cannot send on closed channel
      assert(1 == 0)
    :: ch.closing?true -> // cannot close twice a channel
      assert(2 == 0)
    :: ch.rcving?false;
    :: ch.sending?false -> // sending state of channel (closed)
      assert(1 == 0)
    :: ch.sync!true; 
    fi;
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.deq!false,ch.num_msgs ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		    ch.closed = true
		   :: ch.rcving?false ->
 		    ch.sending?false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.enq?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.rcving?false ->
 		    ch.sending?false;
		fi;
		:: else -> 
		end3: if
		  :: ch.enq?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.deq!false,ch.num_msgs
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		     ch.closed = true
		  :: ch.rcving?false ->
 		    ch.sending?false;
		fi;
	fi;
fi;
od;
}

proctype sync_monitor(Chandef ch) {
do
:: true
if
:: ch.closed ->
end: if
  :: ch.enq?0-> // cannot send on closed channel
    assert(1 == 0)
  :: ch.closing?true -> // cannot close twice a channel
    assert(2 == 0)
  :: ch.sending?false -> // sending state of channel (closed)
    assert(1 == 0)
  :: ch.rcving?false;
  :: ch.sync!true; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.rcving?false ->
       ch.sending?false;
    :: ch.closing?true ->
      ch.closed = true
    fi;
fi;
od
stop_process:
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

