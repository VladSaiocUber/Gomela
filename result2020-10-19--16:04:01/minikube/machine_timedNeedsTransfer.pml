
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example510198664/pkg/minikube/machine/cache_images.go
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
	Chandef timeout;
	int i;
	Chandef transferFinished;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		timeout.size = 1;
		run emptyChan(timeout)
	:: else -> 
		run sync_monitor(timeout)
	fi;
	run Anonymous0(timeout,transferFinished);
	
	if
	:: 1 > 0 -> 
		transferFinished.size = 1;
		run emptyChan(transferFinished)
	:: else -> 
		run sync_monitor(transferFinished)
	fi;
	run Anonymous1(timeout,transferFinished);
	do
	:: transferFinished.async_rcv?0 -> 
		goto stop_process
	:: transferFinished.sync?0 -> 
		goto stop_process
	:: timeout.async_rcv?0 -> 
		goto stop_process
	:: timeout.sync?0 -> 
		goto stop_process
	od
stop_process:}

proctype Anonymous0(Chandef timeout;Chandef transferFinished) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: timeout.async_send!0;
	:: timeout.sync!0 -> 
		timeout.sending?0
	fi;
stop_process:
}
proctype Anonymous1(Chandef timeout;Chandef transferFinished) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: transferFinished.async_send!0;
	:: transferFinished.sync!0 -> 
		transferFinished.sending?0
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

