// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/sync/cond_test.go#L132
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



init { 
	chan child_TestRace1320 = [1] of {int};
	run TestRace132(child_TestRace1320);
	run receiver(child_TestRace1320)
stop_process:skip
}

proctype TestRace132(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestRace1631352 = [1] of {int};
	chan child_AnonymousTestRace1481351 = [1] of {int};
	chan child_AnonymousTestRace1361350 = [1] of {int};
	Chandef done;
	run sync_monitor(done);
	run AnonymousTestRace136135(done,child_AnonymousTestRace1361350);
	run receiver(child_AnonymousTestRace1361350);
	run AnonymousTestRace148135(done,child_AnonymousTestRace1481351);
	run receiver(child_AnonymousTestRace1481351);
	run AnonymousTestRace163135(done,child_AnonymousTestRace1631352);
	run receiver(child_AnonymousTestRace1631352);
	

	if
	:: done.deq?state,num_msgs;
	:: done.sync?state -> 
		done.rcving!false
	fi;
	

	if
	:: done.deq?state,num_msgs;
	:: done.sync?state -> 
		done.rcving!false
	fi;
	

	if
	:: done.deq?state,num_msgs;
	:: done.sync?state -> 
		done.rcving!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousTestRace136135(Chandef done;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: done.enq!0;
	:: done.sync!false -> 
		done.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousTestRace148135(Chandef done;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: done.enq!0;
	:: done.sync!false -> 
		done.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousTestRace163135(Chandef done;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: done.enq!0;
	:: done.sync!false -> 
		done.sending!false
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

proctype receiver(chan c) {
c?0
}

