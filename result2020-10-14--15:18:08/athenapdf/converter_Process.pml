
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example336495960/weaver/converter/worker.go
typedef Chandef {
	chan sync = [0] of {int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
}



init { 
	int i;
	Chandef wout;
	Chandef done;
	Chandef werr;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		done.size = 1;
		run emptyChan(done)
	:: else -> 
		run sync_monitor(done)
	fi;
	
	if
	:: 1 > 0 -> 
		wout.size = 1;
		run emptyChan(wout)
	:: else -> 
		run sync_monitor(wout)
	fi;
	
	if
	:: 1 > 0 -> 
		werr.size = 1;
		run emptyChan(werr)
	:: else -> 
		run sync_monitor(werr)
	fi;
	run Anonymous0(done,wout,werr);
	do
	:: wout.async_rcv?0 -> 
		break
	:: wout.sync?0 -> 
		break
	:: werr.async_rcv?0 -> 
		break
	:: werr.sync?0 -> 
		break
	:: true;
	od;
	done.closing!true
stop_process:}

proctype w_converterConvert(Chandef done;chan child) {
	bool closed; 
	int i;
	bool state;
	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous0(Chandef done;Chandef wout;Chandef werr) {
	bool closed; 
	int i;
	bool state;
	chan child_w_converterConvert0 = [0] of {int};
	run w_converterConvert(done,child_w_converterConvert0);
	child_w_converterConvert0?0;
	
	if
	:: true -> 
		
		if
		:: werr.async_send!0;
		:: werr.sync!0 -> 
			werr.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: werr.async_send!0;
		:: werr.sync!0 -> 
			werr.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: wout.async_send!0;
	:: wout.sync!0 -> 
		wout.sending?0
	fi;
stop_process:
}
proctype sync_monitor(Chandef ch) {
end: if
    :: ch.sending!false;
      run sync_monitor(ch)
    :: ch.closing?true ->
      run closedChan(ch)
    :: ch.is_closed!false ->
      run sync_monitor(ch)
    fi
stop_process:
}

proctype emptyChan(Chandef ch) {
end: if
	 :: ch.async_send?0 -> // a message has been received
    ch.num_msgs = ch.num_msgs + 1
    if
    :: ch.num_msgs == ch.size ->
      run fullChan(ch)
    :: else ->
      run neitherChan(ch)
    fi;
  :: ch.closing?true -> // closing the channel
    run closedChan(ch)
  :: ch.is_closed!false ->
    run emptyChan(ch) // sending channel is open 
  :: ch.sending!false ->
    run emptyChan(ch) // sending channel is open 
fi;
}

proctype fullChan(Chandef ch) {
end: if
  :: ch.async_rcv!0 ->
    ch.num_msgs = ch.num_msgs - 1
    if
    :: ch.num_msgs == 0 ->
      run emptyChan(ch)
    :: else ->
      run neitherChan(ch)
    fi;
  :: ch.closing?true -> // closing the channel
      run closedChan(ch)
  :: ch.is_closed!false -> // sending channel is open 
      run fullChan(ch)
  :: ch.sending!false ->
      run fullChan(ch)
fi;
}

proctype neitherChan(Chandef ch) {
end: if
  :: ch.async_send?0->
     ch.num_msgs = ch.num_msgs + 1
     if
     :: ch.num_msgs == ch.size ->
        run fullChan(ch)
     :: else ->
        run neitherChan(ch)
    fi;
  :: ch.async_rcv!0
     ch.num_msgs = ch.num_msgs - 1
     if
     :: ch.num_msgs == 0 ->
      run emptyChan(ch)
     :: else ->
      run neitherChan(ch)
     fi;
  :: ch.closing?true -> // closing the channel
      run closedChan(ch)
  :: ch.is_closed!false ->  // sending channel is open
     run neitherChan(ch)
  :: ch.sending!false ->  // sending channel is open
     run neitherChan(ch)
fi;
}

proctype closedChan(Chandef ch) {
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true -> // sending state of channel (closed)
    run closedChan(ch)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0 -> // can always receive on a closed chan
    run closedChan(ch)
  fi;
}

