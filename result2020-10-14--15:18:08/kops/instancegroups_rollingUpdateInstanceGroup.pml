#define rollingUpdateInstanceGroup_maxSurge  60
#define rollingUpdateInstanceGroup_maxConcurrency  60
#define rollingUpdateInstanceGroup_update  60
#define lb_for259_3  -1
#define ub_for259_4  -1
#define lb_for208_5  -1
#define ub_for208_6  -1
#define lb_for222_7  -1
#define ub_for222_8  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example764085078/pkg/instancegroups/instancegroups.go
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
	int maxSurge = rollingUpdateInstanceGroup_maxSurge;
	bool state = false;
	int update = rollingUpdateInstanceGroup_update;
	Chandef terminateChan;
	int maxConcurrency = rollingUpdateInstanceGroup_maxConcurrency;
	int i;
	
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
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	
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
		:: 1 != -1 && maxSurge != -1 -> 
						for(i : 1.. maxSurge) {
for10:				
				if
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi;
					
					if
					:: true -> 
						
						if
						:: true -> 
							goto stop_process
						:: true;
						fi
					:: true;
					fi
				:: true;
				fi
			}
		:: else -> 
			do
			:: true -> 
for10:				
				if
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi;
					
					if
					:: true -> 
						
						if
						:: true -> 
							goto stop_process
						:: true;
						fi
					:: true;
					fi
				:: true;
				fi
			:: true -> 
				break
			od
		fi;
for10_exit:
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: maxConcurrency > 0 -> 
		terminateChan.size = maxConcurrency;
		run emptyChan(terminateChan)
	:: else -> 
		run sync_monitor(terminateChan)
	fi;
		for(i : 1.. update) {
for20:		run Anonymous0(terminateChan);
		
		if
		:: terminateChan.async_rcv?0;
		:: terminateChan.sync?0;
		fi;
		
		if
		:: true -> 
			chan child_instancegroupswaitForPendingBeforeReturningError0 = [0] of {int};
			run instancegroupswaitForPendingBeforeReturningError(terminateChan,child_instancegroupswaitForPendingBeforeReturningError0);
			child_instancegroupswaitForPendingBeforeReturningError0?0;
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			chan child_instancegroupswaitForPendingBeforeReturningError1 = [0] of {int};
			run instancegroupswaitForPendingBeforeReturningError(terminateChan,child_instancegroupswaitForPendingBeforeReturningError1);
			child_instancegroupswaitForPendingBeforeReturningError1?0;
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
sweep:				
		if
		:: lb_for208_5 != -1 && ub_for208_6 != -1 -> 
						for(i : lb_for208_5.. ub_for208_6) {
for22:				do
				:: terminateChan.async_rcv?0 -> 
					
					if
					:: true -> 
						chan child_instancegroupswaitForPendingBeforeReturningError2 = [0] of {int};
						run instancegroupswaitForPendingBeforeReturningError(terminateChan,child_instancegroupswaitForPendingBeforeReturningError2);
						child_instancegroupswaitForPendingBeforeReturningError2?0;
						goto stop_process
					:: true;
					fi;
					break
				:: terminateChan.sync?0 -> 
					
					if
					:: true -> 
						chan child_instancegroupswaitForPendingBeforeReturningError2 = [0] of {int};
						run instancegroupswaitForPendingBeforeReturningError(terminateChan,child_instancegroupswaitForPendingBeforeReturningError2);
						child_instancegroupswaitForPendingBeforeReturningError2?0;
						goto stop_process
					:: true;
					fi;
					break
				:: true -> 
					goto sweep;
					break
				od
			}
		:: else -> 
			do
			:: true -> 
for22:				do
				:: terminateChan.async_rcv?0 -> 
					
					if
					:: true -> 
						chan child_instancegroupswaitForPendingBeforeReturningError2 = [0] of {int};
						run instancegroupswaitForPendingBeforeReturningError(terminateChan,child_instancegroupswaitForPendingBeforeReturningError2);
						child_instancegroupswaitForPendingBeforeReturningError2?0;
						goto stop_process
					:: true;
					fi;
					break
				:: terminateChan.sync?0 -> 
					
					if
					:: true -> 
						chan child_instancegroupswaitForPendingBeforeReturningError2 = [0] of {int};
						run instancegroupswaitForPendingBeforeReturningError(terminateChan,child_instancegroupswaitForPendingBeforeReturningError2);
						child_instancegroupswaitForPendingBeforeReturningError2?0;
						goto stop_process
					:: true;
					fi;
					break
				:: true -> 
					goto sweep;
					break
				od
			:: true -> 
				break
			od
		fi;
for22_exit:
	};
	
	if
	:: true -> 
		
		if
		:: lb_for222_7 != -1 && ub_for222_8 != -1 -> 
						for(i : lb_for222_7.. ub_for222_8) {
for30:				
				if
				:: terminateChan.async_rcv?0;
				:: terminateChan.sync?0;
				fi;
				
				if
				:: true -> 
					chan child_instancegroupswaitForPendingBeforeReturningError3 = [0] of {int};
					run instancegroupswaitForPendingBeforeReturningError(terminateChan,child_instancegroupswaitForPendingBeforeReturningError3);
					child_instancegroupswaitForPendingBeforeReturningError3?0;
					goto stop_process
				:: true;
				fi
			}
		:: else -> 
			do
			:: true -> 
for30:				
				if
				:: terminateChan.async_rcv?0;
				:: terminateChan.sync?0;
				fi;
				
				if
				:: true -> 
					chan child_instancegroupswaitForPendingBeforeReturningError3 = [0] of {int};
					run instancegroupswaitForPendingBeforeReturningError(terminateChan,child_instancegroupswaitForPendingBeforeReturningError3);
					child_instancegroupswaitForPendingBeforeReturningError3?0;
					goto stop_process
				:: true;
				fi
			:: true -> 
				break
			od
		fi;
for30_exit:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef terminateChan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: terminateChan.async_send!0;
	:: terminateChan.sync!0 -> 
		terminateChan.sending?0
	fi;
stop_process:
}
proctype instancegroupswaitForPendingBeforeReturningError(Chandef terminateChan;chan child) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: lb_for259_3 != -1 && ub_for259_4 != -1 -> 
				for(i : lb_for259_3.. ub_for259_4) {
for21:			
			if
			:: terminateChan.async_rcv?0;
			:: terminateChan.sync?0;
			fi
		}
	:: else -> 
		do
		:: true -> 
for21:			
			if
			:: terminateChan.async_rcv?0;
			:: terminateChan.sync?0;
			fi
		:: true -> 
			break
		od
	fi;
for21_exit:	goto stop_process;
	child!0;
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

