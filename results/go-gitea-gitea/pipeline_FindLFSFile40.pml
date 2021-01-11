#define ub_for243_0  -2

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example133053963/modules/git/pipeline/lfs_nogogit.go
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
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	Chandef errChan;
	bool state = false;
	int i;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: 1 > 0 -> 
		errChan.size = 1;
		run AsyncChan(errChan)
	:: else -> 
		run sync_monitor(errChan)
	fi;
	run wgMonitor(wg);
	wg.Add!3;
	run go_Anonymous0(errChan,wg);
	run go_NameRevStdin(wg);
	run go_Anonymous2(errChan,wg);
	wg.Wait?0;
	do
	:: errChan.async_rcv?0 -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		break
	:: errChan.sync?0 -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		break
	:: true;
	od;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef errChan;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	stop_process: skip;
	wg.Add!-1
}
proctype go_NameRevStdin(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous2(Chandef errChan;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int results = -2;
	

	if
	:: results-1 != -3 -> 
				for(i : 0.. results-1) {
			for40: skip;
			

			if
			:: true -> 
				

				if
				:: true -> 
					

					if
					:: errChan.async_send!0;
					:: errChan.sync!0 -> 
						errChan.sending?0
					fi;
					break
				:: true;
				fi
			:: true;
			fi;
			

			if
			:: 0 != -2 && ub_for243_0 != -2 -> 
								for(i : 0.. ub_for243_0) {
					for41295: skip;
					

					if
					:: true -> 
						

						if
						:: errChan.async_send!0;
						:: errChan.sync!0 -> 
							errChan.sending?0
						fi;
						break
					:: true;
					fi;
					for41_end295: skip
				};
				for41_exit295: skip
			:: else -> 
				do
				:: true -> 
					for41: skip;
					

					if
					:: true -> 
						

						if
						:: errChan.async_send!0;
						:: errChan.sync!0 -> 
							errChan.sending?0
						fi;
						break
					:: true;
					fi;
					for41_end: skip
				:: true -> 
					break
				od;
				for41_exit: skip
			fi;
			for40_end: skip
		};
		for40_exit: skip
	:: else -> 
		do
		:: true -> 
			for40296: skip;
			

			if
			:: true -> 
				

				if
				:: true -> 
					

					if
					:: errChan.async_send!0;
					:: errChan.sync!0 -> 
						errChan.sending?0
					fi;
					break
				:: true;
				fi
			:: true;
			fi;
			

			if
			:: 0 != -2 && ub_for243_0 != -2 -> 
								for(i : 0.. ub_for243_0) {
					for41295296: skip;
					

					if
					:: true -> 
						

						if
						:: errChan.async_send!0;
						:: errChan.sync!0 -> 
							errChan.sending?0
						fi;
						break
					:: true;
					fi;
					for41_end295296: skip
				};
				for41_exit295296: skip
			:: else -> 
				do
				:: true -> 
					for41296: skip;
					

					if
					:: true -> 
						

						if
						:: errChan.async_send!0;
						:: errChan.sync!0 -> 
							errChan.sending?0
						fi;
						break
					:: true;
					fi;
					for41_end296: skip
				:: true -> 
					break
				od;
				for41_exit296: skip
			fi;
			for40_end296: skip
		:: true -> 
			break
		od;
		for40_exit296: skip
	fi;
	stop_process: skip;
	wg.Add!-1
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

proctype wgMonitor(Wgdef wg) {
bool closed;
int i;
bool state;
do
	:: wg.Add?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.Add?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
	fi
od
}

