#define MRun_maxTTL  60
#define lb_for460_1  -1
#define ub_for460_2  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example263572852/icmp/trace.go
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
	int maxTTL = MRun_maxTTL;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		c.size = 1;
		run emptyChan(c)
	:: else -> 
		run sync_monitor(c)
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Anonymous0(c);
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef c) {
	bool closed; 
	int i;
	bool state;
stop_process:
}
proctype Anonymous0(Chandef c) {
	bool closed; 
	int i;
	bool state;
LOOP:		do
	:: true -> 
for10:				for(i : 1.. maxTTL) {
for11:			
			if
			:: true -> 
				
				if
				:: true -> 
					run Anonymous0(c)
				:: true;
				fi
			fi;
			
			if
			:: c.async_send!0;
			:: c.sync!0 -> 
				c.sending?0
			fi
		};
for11_exit:		
		if
		:: true -> 
			goto LOOP
		:: true;
		fi
	od;
for10_exit:;
	c.closing!true;
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

