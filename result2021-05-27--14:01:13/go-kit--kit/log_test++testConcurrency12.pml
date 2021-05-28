// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/go-kit/kit/blob/60e8424101af501c525efaf67c0a2edf08667f80/log/concurrency_test.go#L12
#define testConcurrency_n  ??
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
	chan child_testConcurrency120 = [1] of {int};
	run testConcurrency12(child_testConcurrency120);
	run receiver(child_testConcurrency120)
stop_process:skip
}

proctype testConcurrency12(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymoustestConcurrency19160 = [1] of {int};
	Chandef errC;
	int n = testConcurrency_n; // mand n
	

	if
	:: n > 0 -> 
		errC.size = n;
		run AsyncChan(errC)
	:: else -> 
		run sync_monitor(errC)
	fi;
		for(i : 0.. n-1) {
		for10: skip;
		run AnonymoustestConcurrency1916(errC,child_AnonymoustestConcurrency19160);
		run receiver(child_AnonymoustestConcurrency19160);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: 0 != -2 && n-1 != -3 -> 
				for(i : 0.. n-1) {
			for21: skip;
			

			if
			:: errC.deq?state,num_msgs;
			:: errC.sync?state -> 
				errC.rcving!false
			fi;
			for21_end: skip
		};
		for21_exit: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: errC.deq?state,num_msgs;
			:: errC.sync?state -> 
				errC.rcving!false
			fi;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymoustestConcurrency1916(Chandef errC;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: errC.enq!0;
	:: errC.sync!false -> 
		errC.sending!false
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

