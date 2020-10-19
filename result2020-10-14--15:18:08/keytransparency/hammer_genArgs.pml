#define genArgs_qps  60
#define genArgs_count  60
#define genArgs_batch  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example761573406/core/client/hammer/hammer.go
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
	int count = genArgs_count;
	Chandef inflightReqs;
	int i;
	int qps = genArgs_qps;
	int batch = genArgs_batch;
	bool state = false;
	
	if
	:: qps > 0 -> 
		inflightReqs.size = qps;
		run emptyChan(inflightReqs)
	:: else -> 
		run sync_monitor(inflightReqs)
	fi;
	run Anonymous0(inflightReqs);
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef inflightReqs) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: 0 != -1 && count-1 != -1 -> 
				for(i : 0.. count-1) {
for10:			
			if
			:: 0 != -1 && batch-1 != -1 -> 
								for(i : 0.. batch-1) {
for11:
				}
			:: else -> 
				do
				:: true -> 
for11:
				:: true -> 
					break
				od
			fi;
for11_exit:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: inflightReqs.async_send!0;
			:: inflightReqs.sync!0 -> 
				inflightReqs.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: 0 != -1 && batch-1 != -1 -> 
								for(i : 0.. batch-1) {
for11:
				}
			:: else -> 
				do
				:: true -> 
for11:
				:: true -> 
					break
				od
			fi;
for11_exit:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: inflightReqs.async_send!0;
			:: inflightReqs.sync!0 -> 
				inflightReqs.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	inflightReqs.closing!true;
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

