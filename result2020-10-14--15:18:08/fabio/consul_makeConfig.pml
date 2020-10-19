#define makeConfig_checks  60
#define makeConfig_n  60
#define makeConfig_m  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example950197323/registry/consul/service.go
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
	Chandef sem;
	int m = makeConfig_m;
	int checks = makeConfig_checks;
	bool state = false;
	Chandef cfgs;
	int n = makeConfig_n;
	int i;
		for(i : 1.. checks) {
for10:
	};
	
	if
	:: n > 0 -> 
		sem.size = n;
		run emptyChan(sem)
	:: else -> 
		run sync_monitor(sem)
	fi;
	
	if
	:: m > 0 -> 
		cfgs.size = m;
		run emptyChan(cfgs)
	:: else -> 
		run sync_monitor(cfgs)
	fi;
		for(i : 1.. m) {
for20:		run Anonymous0(sem,cfgs)
	};
	
	if
	:: 0 != -1 && m-1 != -1 -> 
				for(i : 0.. m-1) {
for30:			
			if
			:: cfgs.async_rcv?0;
			:: cfgs.sync?0;
			fi
		}
	:: else -> 
		do
		:: true -> 
for30:			
			if
			:: cfgs.async_rcv?0;
			:: cfgs.sync?0;
			fi
		:: true -> 
			break
		od
	fi;
for30_exit:	goto stop_process
stop_process:}

proctype Anonymous0(Chandef sem;Chandef cfgs) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: sem.async_send!0;
	:: sem.sync!0 -> 
		sem.sending?0
	fi;
	
	if
	:: cfgs.async_send!0;
	:: cfgs.sync!0 -> 
		cfgs.sending?0
	fi;
	
	if
	:: sem.async_rcv?0;
	:: sem.sync?0;
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

