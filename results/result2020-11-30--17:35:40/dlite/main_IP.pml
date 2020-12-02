#define lb_for262_0  -1
#define ub_for262_1  -1

// /tmp/clone-example432456458/vm.go
typedef Chandef {
	chan sync = [0] of {int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}



init { 
	Chandef value;
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: 1 > 0 -> 
		value.size = 1;
		run AsyncChan(value)
	:: else -> 
		run sync_monitor(value)
	fi;
	run Anonymous0(value);
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef value) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			
			if
			:: value.async_send!0;
			:: value.sync!0 -> 
				value.sending?0
			fi;
			break
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: value.async_send!0;
			:: value.sync!0 -> 
				value.sending?0
			fi;
			break
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: value.async_send!0;
			:: value.sync!0 -> 
				value.sending?0
			fi;
			break
		:: true;
		fi;
				for(i : 0.. blocks-1) {
for11:			
			if
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: value.async_send!0;
					:: value.sync!0 -> 
						value.sending?0
					fi;
					break
				:: true;
				fi
			:: true;
			fi
		}
	od;
for10_exit:stop_process:
}
proctype AsyncChan(Chandef ch) {
do
:: true ->
if
:: ch.closed -> 
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!0 ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false; // sending channel is open 
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.is_closed!false;
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!0
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false;  // sending channel is open
		  :: ch.sending!false;  // sending channel is open
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
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
    :: ch.is_closed!false ->
    fi;
fi;
od
stop_process:
}

