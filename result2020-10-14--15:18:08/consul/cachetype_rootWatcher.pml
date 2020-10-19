#define rootWatcher_c_rootWatchSubscribers  60
#define lb_for86_1  -1
#define ub_for86_2  -1
#define lb_for146_3  -1
#define ub_for146_4  -1
#define lb_for208_5  -1
#define ub_for208_6  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example545415543/agent/cache-types/connect_ca_leaf.go
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
	int i;
	chan child_c_CacheNotify0 = [0] of {int};
	Chandef ch;
	int c_rootWatchSubscribers = rootWatcher_c_rootWatchSubscribers;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		ch.size = 1;
		run emptyChan(ch)
	:: else -> 
		run sync_monitor(ch)
	fi;
	run c_CacheNotify(ch,child_c_CacheNotify0);
	child_c_CacheNotify0?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for30:		do
		:: ch.async_rcv?0 -> 
			break
		:: ch.sync?0 -> 
			break
		od
	od;
for30_exit:
stop_process:}

proctype c_CacheNotify(Chandef ch;chan child) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		run go_cnotifyBlockingQuery(ch);
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run go_cnotifyPollingQuery(ch);
	goto stop_process;
	child!0;
stop_process:
}
proctype go_cnotifyBlockingQuery(Chandef ch) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			do
			:: ch.async_send!0 -> 
				break
			:: ch.sync!0 -> 
				ch.sending?0;
				break
			od
		:: true;
		fi;
		
		if
		:: true -> 
			do
			:: true;
			od
		:: true;
		fi
	od;
for10_exit:stop_process:
}
proctype go_cnotifyPollingQuery(Chandef ch) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for20:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			do
			:: ch.async_send!0 -> 
				break
			:: ch.sync!0 -> 
				ch.sending?0;
				break
			od
		:: true;
		fi;
		do
		:: true;
		od
	od;
for20_exit:stop_process:
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

