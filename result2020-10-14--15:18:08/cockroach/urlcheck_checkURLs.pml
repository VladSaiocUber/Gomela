#define checkURLs_uniqueURLs  60
#define checkURLs_locs  60
#define checkURLs_errs  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example543475193/pkg/cmd/urlcheck/lib/urlcheck/urlcheck.go
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
	Chandef errChan;
	int i;
	int locs = checkURLs_locs;
	Chandef sem;
	int uniqueURLs = checkURLs_uniqueURLs;
	int errs = checkURLs_errs;
	bool state = false;
	
	if
	:: 20 > 0 -> 
		sem.size = 20;
		run emptyChan(sem)
	:: else -> 
		run sync_monitor(sem)
	fi;
	
	if
	:: uniqueURLs > 0 -> 
		errChan.size = uniqueURLs;
		run emptyChan(errChan)
	:: else -> 
		run sync_monitor(errChan)
	fi;
		for(i : 1.. uniqueURLs) {
for10:		
		if
		:: sem.async_send!0;
		:: sem.sync!0 -> 
			sem.sending?0
		fi;
		run Anonymous0(sem,errChan)
	};
	
	if
	:: 0 != -1 && uniqueURLs-1 != -1 -> 
				for(i : 0.. uniqueURLs-1) {
for20:			
			if
			:: errChan.async_rcv?0;
			:: errChan.sync?0;
			fi
		}
	:: else -> 
		do
		:: true -> 
for20:			
			if
			:: errChan.async_rcv?0;
			:: errChan.sync?0;
			fi
		:: true -> 
			break
		od
	fi;
for20_exit:	
	if
	:: true -> 
				for(i : 1.. errs) {
for30:
		};
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef sem;Chandef errChan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
				for(i : 1.. locs) {
for11:
		};
		
		if
		:: errChan.async_send!0;
		:: errChan.sync!0 -> 
			errChan.sending?0
		fi
	:: true -> 
		
		if
		:: errChan.async_send!0;
		:: errChan.sync!0 -> 
			errChan.sending?0
		fi
	:: true -> 
		
		if
		:: errChan.async_send!0;
		:: errChan.sync!0 -> 
			errChan.sending?0
		fi
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

