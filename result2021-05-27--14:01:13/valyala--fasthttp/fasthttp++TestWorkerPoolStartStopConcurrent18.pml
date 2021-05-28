// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/valyala/fasthttp/blob/19fcd408632d6dae8425ae95c6c62a25c823ff81/workerpool_test.go#L18
#define TestWorkerPoolStartStopConcurrent_concurrency  ??
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
	chan child_TestWorkerPoolStartStopConcurrent180 = [1] of {int};
	run TestWorkerPoolStartStopConcurrent18(child_TestWorkerPoolStartStopConcurrent180);
	run receiver(child_TestWorkerPoolStartStopConcurrent180)
stop_process:skip
}

proctype TestWorkerPoolStartStopConcurrent18(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestWorkerPoolStartStopConcurrent24220 = [1] of {int};
	Chandef ch;
	int concurrency = TestWorkerPoolStartStopConcurrent_concurrency; // mand concurrency
	

	if
	:: concurrency > 0 -> 
		ch.size = concurrency;
		run AsyncChan(ch)
	:: else -> 
		run sync_monitor(ch)
	fi;
		for(i : 0.. concurrency-1) {
		for10: skip;
		run AnonymousTestWorkerPoolStartStopConcurrent2422(ch,child_AnonymousTestWorkerPoolStartStopConcurrent24220);
		run receiver(child_AnonymousTestWorkerPoolStartStopConcurrent24220);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: 0 != -2 && concurrency-1 != -3 -> 
				for(i : 0.. concurrency-1) {
			for22: skip;
			do
			:: ch.deq?state,num_msgs -> 
				break
			:: ch.sync?state -> 
				ch.rcving!false;
				break
			:: true -> 
				break
			od;
			for23_exit: skip;
			for22_end: skip
		};
		for22_exit: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			do
			:: ch.deq?state,num_msgs -> 
				break
			:: ch.sync?state -> 
				ch.rcving!false;
				break
			:: true -> 
				break
			od;
			for21_exit: skip;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousTestWorkerPoolStartStopConcurrent2422(Chandef ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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

proctype receiver(chan c) {
c?0
}

