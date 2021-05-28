// num_comm_params=2
// num_mand_comm_params=1
// num_opt_comm_params=1

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/os/os_test.go#L2439
#define TestPipeThreads_threads  ??
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
	chan child_TestPipeThreads24390 = [1] of {int};
	run TestPipeThreads2439(child_TestPipeThreads24390);
	run receiver(child_TestPipeThreads24390)
stop_process:skip
}

proctype TestPipeThreads2439(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestPipeThreads248024800 = [1] of {int};
	Chandef cdone;
	Chandef creading;
	int i = -2; // opt i
	int threads = TestPipeThreads_threads; // mand threads
	

	if
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	fi;
	

	if
	:: threads > 0 -> 
		creading.size = threads;
		run AsyncChan(creading)
	:: else -> 
		run sync_monitor(creading)
	fi;
	

	if
	:: threads > 0 -> 
		cdone.size = threads;
		run AsyncChan(cdone)
	:: else -> 
		run sync_monitor(cdone)
	fi;
		for(i : 0.. threads-1) {
		for20: skip;
		run AnonymousTestPipeThreads24802480(creading,cdone,child_AnonymousTestPipeThreads248024800);
		run receiver(child_AnonymousTestPipeThreads248024800);
		for20_end: skip
	};
	for20_exit: skip;
	

	if
	:: 0 != -2 && threads-1 != -3 -> 
				for(i : 0.. threads-1) {
			for31: skip;
			

			if
			:: creading.deq?state,num_msgs;
			:: creading.sync?state -> 
				creading.rcving!false
			fi;
			for31_end: skip
		};
		for31_exit: skip
	:: else -> 
		do
		:: true -> 
			for30: skip;
			

			if
			:: creading.deq?state,num_msgs;
			:: creading.sync?state -> 
				creading.rcving!false
			fi;
			for30_end: skip
		:: true -> 
			break
		od;
		for30_exit: skip
	fi;
	

	if
	:: 0 != -2 && threads-1 != -3 -> 
				for(i : 0.. threads-1) {
			for41: skip;
			

			if
			:: cdone.deq?state,num_msgs;
			:: cdone.sync?state -> 
				cdone.rcving!false
			fi;
			for41_end: skip
		};
		for41_exit: skip
	:: else -> 
		do
		:: true -> 
			for40: skip;
			

			if
			:: cdone.deq?state,num_msgs;
			:: cdone.sync?state -> 
				cdone.rcving!false
			fi;
			for40_end: skip
		:: true -> 
			break
		od;
		for40_exit: skip
	fi;
		stop_process: skip;
	stop_process: skip;
	child!0
}
proctype AnonymousTestPipeThreads24802480(Chandef creading;Chandef cdone;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: creading.enq!0;
	:: creading.sync!false -> 
		creading.sending!false
	fi;
	

	if
	:: cdone.enq!0;
	:: cdone.sync!false -> 
		cdone.sending!false
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

