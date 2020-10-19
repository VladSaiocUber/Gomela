#define parallelTest_workers  60
#define parallelTest_fns  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example259590329/test/extended/networking/internal_ports.go
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
	Chandef work;
	int i;
	int workers = parallelTest_workers;
	Wgdef wg;
	Chandef results;
	int fns = parallelTest_fns;
	bool state = false;
	run wgMonitor(wg);
	
	if
	:: workers > 0 -> 
		work.size = workers;
		run emptyChan(work)
	:: else -> 
		run sync_monitor(work)
	fi;
	
	if
	:: workers > 0 -> 
		results.size = workers;
		run emptyChan(results)
	:: else -> 
		run sync_monitor(results)
	fi;
	run Anonymous0(work,results,wg);
		for(i : 0.. workers-1) {
for20:		run Anonymous1(work,results,wg)
	};
for20_exit:	do
	:: results.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: results.async_rcv?0;
			:: results.sync?0;
			fi
		fi
	od;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef work;Chandef results;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
		for(i : 1.. fns) {
for10:		
		if
		:: work.async_send!0;
		:: work.sync!0 -> 
			work.sending?0
		fi;
		wg.Add!1
	};
	work.closing!true;
	wg.Wait?0;
	results.closing!true;
stop_process:
}
proctype Anonymous1(Chandef work;Chandef results;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: work.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: work.async_rcv?0;
			:: work.sync?0;
			fi;
			
			if
			:: results.async_send!0;
			:: results.sync!0 -> 
				results.sending?0
			fi;
			wg.Add!-1
		fi
	od;
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

