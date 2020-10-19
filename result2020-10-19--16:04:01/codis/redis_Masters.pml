#define Masters_sentinels  5
#define Masters_m  5
#define lb_for385_2  -1
#define ub_for385_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example363806314/pkg/utils/redis/sentinel.go
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
	int sentinels = Masters_sentinels;
	Chandef results;
	int m = Masters_m;
	bool state = false;
	
	if
	:: sentinels > 0 -> 
		results.size = sentinels;
		run emptyChan(results)
	:: else -> 
		run sync_monitor(results)
	fi;
		for(i : 1.. sentinels) {
for10:		run Anonymous0(results)
	};
	
	if
	:: lb_for385_2 != -1 && ub_for385_3 != -1 -> 
				for(i : lb_for385_2.. ub_for385_3) {
for20:			
			if
			:: true -> 
				

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
				goto stop_process
			:: true;
			fi;
			do
			:: results.async_rcv?0 -> 
								for(i : 1.. m) {
for21:
				};
				break
			:: results.sync?0 -> 
								for(i : 1.. m) {
for21:
				};
				break
			od
		}
	:: else -> 
		do
		:: true -> 
for20:			
			if
			:: true -> 
				

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
				goto stop_process
			:: true;
			fi;
			do
			:: results.async_rcv?0 -> 
								for(i : 1.. m) {
for21:
				};
				break
			:: results.sync?0 -> 
								for(i : 1.. m) {
for21:
				};
				break
			od
		:: true -> 
			break
		od
	fi;
for20_exit:
stop_process:}

proctype Anonymous0(Chandef results) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: results.async_send!0;
	:: results.sync!0 -> 
		results.sending?0
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

