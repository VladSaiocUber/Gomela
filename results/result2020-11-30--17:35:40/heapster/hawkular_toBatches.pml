#define toBatches_size  0
#define lb_for322_1  -1
#define ub_for322_2  -1

// /tmp/clone-example898288434/metrics/sinks/hawkular/client.go
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
	bool state = false;
	int size = toBatches_size;
	Chandef c;
	int i;
	
	if
	:: true -> 
		Chandef c;
		
		if
		:: 1 > 0 -> 
			c.size = 1;
			run AsyncChan(c)
		:: else -> 
			run sync_monitor(c)
		fi;
		
		if
		:: c.async_send!0;
		:: c.sync!0 -> 
			c.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: size > 0 -> 
		c.size = size;
		run AsyncChan(c)
	:: else -> 
		run sync_monitor(c)
	fi;
	
	if
	:: lb_for322_1 != -2 && ub_for322_2 != -2 -> 
				for(i : lb_for322_1.. ub_for322_2) {
for10:			
			if
			:: c.async_send!0;
			:: c.sync!0 -> 
				c.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: c.async_send!0;
			:: c.sync!0 -> 
				c.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	goto stop_process
stop_process:}

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

