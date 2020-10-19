#define syncNodes_createDiff  60
#define syncNodes_deleteDiff  60
#define syncNodes_batchSize  60
#define syncNodes_pos  60
#define lb_for957_4  -1
#define ub_for957_5  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example603064843/pkg/controller/daemon/daemon_controller.go
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
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int pos = syncNodes_pos;
	Wgdef deleteWait;
	Chandef errCh;
	int deleteDiff = syncNodes_deleteDiff;
	bool state = false;
	Wgdef createWait;
	int createDiff = syncNodes_createDiff;
	int batchSize = syncNodes_batchSize;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: createDiff + deleteDiff > 0 -> 
		errCh.size = createDiff + deleteDiff;
		run emptyChan(errCh)
	:: else -> 
		run sync_monitor(errCh)
	fi;
	run wgMonitor(createWait);
	
	if
	:: lb_for957_4 != -1 && ub_for957_5 != -1 -> 
				for(i : lb_for957_4.. ub_for957_5) {
for10:			createWait.Add!batchSize;
						for(i : pos.. pos + batchSize-1) {
for11:				run Anonymous0(errCh)
			};
for11_exit:			createWait.Wait?0;
			
			if
			:: true -> 
				break
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			createWait.Add!batchSize;
						for(i : pos.. pos + batchSize-1) {
for11:				run Anonymous0(errCh)
			};
for11_exit:			createWait.Wait?0;
			
			if
			:: true -> 
				break
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	run wgMonitor(deleteWait);
	deleteWait.Add!deleteDiff;
		for(i : 0.. deleteDiff-1) {
for20:		run Anonymous1(errCh)
	};
for20_exit:	deleteWait.Wait?0;
	errCh.closing!true;
	do
	:: errCh.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: errCh.async_rcv?0;
			:: errCh.sync?0;
			fi
		fi
	od;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef errCh) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: errCh.async_send!0;
		:: errCh.sync!0 -> 
			errCh.sending?0
		fi
	:: true;
	fi;
stop_process:
}
proctype Anonymous1(Chandef errCh) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: errCh.async_send!0;
			:: errCh.sync!0 -> 
				errCh.sending?0
			fi
		:: true;
		fi
	:: true;
	fi;
stop_process:
}
proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: wg.Add?i -> 
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 -> 
end:		
		if
		:: wg.Add?i -> 
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
		fi
	od;
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

