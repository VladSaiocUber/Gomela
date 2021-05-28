// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/valyala/fasthttp/blob/19fcd408632d6dae8425ae95c6c62a25c823ff81/http_test.go#L2348
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
	chan child_TestResponseImmediateHeaderFlushChunked23480 = [1] of {int};
	run TestResponseImmediateHeaderFlushChunked2348(child_TestResponseImmediateHeaderFlushChunked23480);
	run receiver(child_TestResponseImmediateHeaderFlushChunked23480)
stop_process:skip
}

proctype TestResponseImmediateHeaderFlushChunked2348(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestResponseImmediateHeaderFlushChunked237023680 = [1] of {int};
	Chandef waitForIt;
	Chandef cb;
	Chandef ch;
	run sync_monitor(ch);
	run sync_monitor(cb);
	run sync_monitor(waitForIt);
	run AnonymousTestResponseImmediateHeaderFlushChunked23702368(waitForIt,ch,cb,child_AnonymousTestResponseImmediateHeaderFlushChunked237023680);
	run receiver(child_AnonymousTestResponseImmediateHeaderFlushChunked237023680);
	

	if
	:: ch.enq!0;
	:: ch.sync!false -> 
		ch.sending!false
	fi;
	

	if
	:: cb.deq?state,num_msgs;
	:: cb.sync?state -> 
		cb.rcving!false
	fi;
	

	if
	:: ch.enq!0;
	:: ch.sync!false -> 
		ch.sending!false
	fi;
	

	if
	:: waitForIt.deq?state,num_msgs;
	:: waitForIt.sync?state -> 
		waitForIt.rcving!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousTestResponseImmediateHeaderFlushChunked23702368(Chandef waitForIt;Chandef ch;Chandef cb;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: waitForIt.enq!0;
	:: waitForIt.sync!false -> 
		waitForIt.sending!false
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

