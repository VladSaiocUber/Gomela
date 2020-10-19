
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example437804699/app/channel.go
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
	Chandef uc1;
	int i;
	Chandef uc2;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		uc1.size = 1;
		run emptyChan(uc1)
	:: else -> 
		run sync_monitor(uc1)
	fi;
	
	if
	:: 1 > 0 -> 
		uc2.size = 1;
		run emptyChan(uc2)
	:: else -> 
		run sync_monitor(uc2)
	fi;
	run Anonymous0(uc1,uc2);
	run Anonymous1(uc1,uc2);
	
	if
	:: uc1.async_rcv?0;
	:: uc1.sync?0;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: uc2.async_rcv?0;
	:: uc2.sync?0;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true -> 
				goto stop_process
			:: true -> 
				goto stop_process
			fi
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true -> 
				goto stop_process
			fi
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef uc1;Chandef uc2) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: uc1.async_send!0;
	:: uc1.sync!0 -> 
		uc1.sending?0
	fi;
	uc1.closing!true;
stop_process:
}
proctype Anonymous1(Chandef uc1;Chandef uc2) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: uc2.async_send!0;
	:: uc2.sync!0 -> 
		uc2.sending?0
	fi;
	uc2.closing!true;
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

