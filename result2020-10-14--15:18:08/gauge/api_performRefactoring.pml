
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example058759064/api/apiMessageHandler.go
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
	Chandef c;
	int i;
	chan child_apiConnectToRunner2 = [0] of {int};
	bool state = false;
	run sync_monitor(c);
	run apiConnectToRunner(c,child_apiConnectToRunner0);
	child_apiConnectToRunner2?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype apiConnectToRunner(Chandef killChannel;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_runnerStart1 = [0] of {int};
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run runnerStart(killChannel,child_runnerStart0);
	child_runnerStart1?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	child!0;
stop_process:
}
proctype runnerStart(Chandef killChannel;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_runnerStartLegacyRunner0 = [0] of {int};
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run runnerStartLegacyRunner(killChannel,child_runnerStartLegacyRunner0);
	child_runnerStartLegacyRunner0?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	child!0;
stop_process:
}
proctype runnerStartLegacyRunner(Chandef killChannel;chan child) {
	bool closed; 
	int i;
	bool state;
	Chandef errChannel;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Anonymous3(errChannel,killChannel);
	run sync_monitor(errChannel);
	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous3(Chandef errChannel;Chandef killChannel) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: killChannel.async_rcv?0;
	:: killChannel.sync?0;
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

