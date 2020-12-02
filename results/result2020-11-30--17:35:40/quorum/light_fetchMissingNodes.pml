#define fetchMissingNodes_types_BloomBitLength  3
#define lb_for288_1  -1
#define ub_for288_2  -1

// /tmp/clone-example903492413/light/postprocess.go
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
	Chandef resCh;
	int i;
	int uint30711 = -2;
	Chandef indexCh;
	int types_BloomBitLength = fetchMissingNodes_types_BloomBitLength;
	int uint31211 = -2;
	bool state = false;
	
	if
	:: types_BloomBitLength > 0 -> 
		indexCh.size = types_BloomBitLength;
		run AsyncChan(indexCh)
	:: else -> 
		run sync_monitor(indexCh)
	fi;
	
	if
	:: types_BloomBitLength > 0 -> 
		resCh.size = types_BloomBitLength;
		run AsyncChan(resCh)
	:: else -> 
		run sync_monitor(resCh)
	fi;
for10_exit:	
	if
	:: uint30711 != -2 && types_BloomBitLength-1 != -3 -> 
				for(i : uint30711.. types_BloomBitLength-1) {
for20:			
			if
			:: indexCh.async_send!0;
			:: indexCh.sync!0 -> 
				indexCh.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for20:			
			if
			:: indexCh.async_send!0;
			:: indexCh.sync!0 -> 
				indexCh.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for20_exit:	indexCh.closing!true;
	
	if
	:: uint31211 != -2 && types_BloomBitLength-1 != -3 -> 
				for(i : uint31211.. types_BloomBitLength-1) {
for30:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for30:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for30_exit:	goto stop_process
stop_process:}

proctype Anonymous0(Chandef indexCh;Chandef resCh) {
	bool closed; 
	int i;
	bool state;
	do
	:: indexCh.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: indexCh.async_rcv?0;
			:: indexCh.sync?0;
			fi;
			do
			:: true -> 
for12:				
				if
				:: true -> 
					do
					:: true;
					od
				:: true -> 
					
					if
					:: resCh.async_send!0;
					:: resCh.sync!0 -> 
						resCh.sending?0
					fi;
					break
				:: true -> 
					
					if
					:: resCh.async_send!0;
					:: resCh.sync!0 -> 
						resCh.sending?0
					fi;
					break
				fi
			od;
for12_exit:
		fi
	od;
stop_process:
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

