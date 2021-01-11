#define GetCleanEncodedBlocksSizeSum_ptrs  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example918102479/libkbfs/folder_block_ops.go
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
	Chandef sumCh;
	Chandef ptrCh;
	bool state = false;
	int i;
	int ptrs = GetCleanEncodedBlocksSizeSum_ptrs;
	

	if
	:: ptrs > 0 -> 
		ptrCh.size = ptrs;
		run AsyncChan(ptrCh)
	:: else -> 
		run sync_monitor(ptrCh)
	fi;
	

	if
	:: ptrs > 0 -> 
		sumCh.size = ptrs;
		run AsyncChan(sumCh)
	:: else -> 
		run sync_monitor(sumCh)
	fi;
	

	if
	:: ptrs-1 != -3 -> 
				for(i : 0.. ptrs-1) {
			for10: skip;
			

			if
			:: ptrCh.async_send!0;
			:: ptrCh.sync!0 -> 
				ptrCh.sending?0
			fi;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for102172: skip;
			

			if
			:: ptrCh.async_send!0;
			:: ptrCh.sync!0 -> 
				ptrCh.sending?0
			fi;
			for10_end2172: skip
		:: true -> 
			break
		od;
		for10_exit2172: skip
	fi;
	ptrCh.closing!true;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	sumCh.closing!true;
	do
	:: sumCh.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			

			if
			:: sumCh.async_rcv?0;
			:: sumCh.sync?0;
			fi;
			for30: skip;
			for30_end: skip
		fi
	od;
	for30_exit: skip;
	goto stop_process
stop_process:skip
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

