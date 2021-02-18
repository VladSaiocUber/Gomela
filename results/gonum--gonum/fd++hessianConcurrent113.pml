#define hessianConcurrent_evals  3
#define hessianConcurrent_nWorkers  1

// https://github.com/gonum/gonum/blob/090a5d652c892e8d5460a07eca1c1ddf480b04d9/diff/fd/hessian.go#L113
typedef Chandef {
	chan sync = [0] of {bool,int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {bool,int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef workerWG;
	Wgdef originWG;
	Chandef ans;
	Chandef send;
	int num_msgs = 0;
	bool state = false;
	int i;
	int nWorkers = hessianConcurrent_nWorkers;
	int evals = hessianConcurrent_evals;
	

	if
	:: evals > 0 -> 
		send.size = evals;
		run AsyncChan(send)
	:: else -> 
		run sync_monitor(send)
	fi;
	

	if
	:: evals > 0 -> 
		ans.size = evals;
		run AsyncChan(ans)
	:: else -> 
		run sync_monitor(ans)
	fi;
	run wgMonitor(originWG);
	

	if
	:: true -> 
		originWG.Add!1;
		run go_Anonymous0(send,ans,originWG)
	:: true;
	fi;
	run wgMonitor(workerWG);
		for(i : 0.. nWorkers-1) {
		for10: skip;
		workerWG.Add!1;
		run go_Anonymous1(send,ans,originWG,workerWG);
		for10_end: skip
	};
	for10_exit: skip;
	run go_Anonymous2(send,ans,originWG,workerWG);
	do
	:: true -> 
		

		if
		:: ans.async_rcv?state,num_msgs;
		:: ans.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for30: skip;
			for30_end: skip
		fi
	od;
	for30_exit: skip
stop_process:skip
}

proctype go_Anonymous0(Chandef send;Chandef ans;Wgdef originWG) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	originWG.Add!-1
}
proctype go_Anonymous1(Chandef send;Chandef ans;Wgdef originWG;Wgdef workerWG) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		

		if
		:: send.async_rcv?state,num_msgs;
		:: send.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for11: skip;
			

			if
			:: true -> 
				originWG.Wait?0
			fi;
			

			if
			:: ans.async_send!0;
			:: ans.sync!false,0 -> 
				ans.sending?state
			fi;
			for11_end: skip
		fi
	od;
	for11_exit: skip;
	stop_process: skip;
	workerWG.Add!-1
}
proctype go_Anonymous2(Chandef send;Chandef ans;Wgdef originWG;Wgdef workerWG) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int stencil = -2;
	int i = -2;
	int n = -2;
	

	if
	:: 0 != -2 && n-1 != -3 -> 
				for(i : 0.. n-1) {
			for20386: skip;
			

			if
			:: i != -2 && n-1 != -3 -> 
								for(i : i.. n-1) {
					for21385386: skip;
					

					if
					:: stencil-1 != -3 -> 
												for(i : 0.. stencil-1) {
							for22385386: skip;
							

							if
							:: stencil-1 != -3 -> 
																for(i : 0.. stencil-1) {
									for23385386: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end385386: skip
								};
								for23_exit385386: skip
							:: else -> 
								do
								:: true -> 
									for23383385386: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end383385386: skip
								:: true -> 
									break
								od;
								for23_exit383385386: skip
							fi;
							for22_end385386: skip
						};
						for22_exit385386: skip
					:: else -> 
						do
						:: true -> 
							for22384385386: skip;
							

							if
							:: stencil-1 != -3 -> 
																for(i : 0.. stencil-1) {
									for23384385386: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end384385386: skip
								};
								for23_exit384385386: skip
							:: else -> 
								do
								:: true -> 
									for23383384385386: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end383384385386: skip
								:: true -> 
									break
								od;
								for23_exit383384385386: skip
							fi;
							for22_end384385386: skip
						:: true -> 
							break
						od;
						for22_exit384385386: skip
					fi;
					for21_end385386: skip
				};
				for21_exit385386: skip
			:: else -> 
				do
				:: true -> 
					for21386: skip;
					

					if
					:: stencil-1 != -3 -> 
												for(i : 0.. stencil-1) {
							for22386: skip;
							

							if
							:: stencil-1 != -3 -> 
																for(i : 0.. stencil-1) {
									for23386: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end386: skip
								};
								for23_exit386: skip
							:: else -> 
								do
								:: true -> 
									for23383386: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end383386: skip
								:: true -> 
									break
								od;
								for23_exit383386: skip
							fi;
							for22_end386: skip
						};
						for22_exit386: skip
					:: else -> 
						do
						:: true -> 
							for22384386: skip;
							

							if
							:: stencil-1 != -3 -> 
																for(i : 0.. stencil-1) {
									for23384386: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end384386: skip
								};
								for23_exit384386: skip
							:: else -> 
								do
								:: true -> 
									for23383384386: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end383384386: skip
								:: true -> 
									break
								od;
								for23_exit383384386: skip
							fi;
							for22_end384386: skip
						:: true -> 
							break
						od;
						for22_exit384386: skip
					fi;
					for21_end386: skip
				:: true -> 
					break
				od;
				for21_exit386: skip
			fi;
			for20_end386: skip
		};
		for20_exit386: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: i != -2 && n-1 != -3 -> 
								for(i : i.. n-1) {
					for21385: skip;
					

					if
					:: stencil-1 != -3 -> 
												for(i : 0.. stencil-1) {
							for22385: skip;
							

							if
							:: stencil-1 != -3 -> 
																for(i : 0.. stencil-1) {
									for23385: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end385: skip
								};
								for23_exit385: skip
							:: else -> 
								do
								:: true -> 
									for23383385: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end383385: skip
								:: true -> 
									break
								od;
								for23_exit383385: skip
							fi;
							for22_end385: skip
						};
						for22_exit385: skip
					:: else -> 
						do
						:: true -> 
							for22384385: skip;
							

							if
							:: stencil-1 != -3 -> 
																for(i : 0.. stencil-1) {
									for23384385: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end384385: skip
								};
								for23_exit384385: skip
							:: else -> 
								do
								:: true -> 
									for23383384385: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end383384385: skip
								:: true -> 
									break
								od;
								for23_exit383384385: skip
							fi;
							for22_end384385: skip
						:: true -> 
							break
						od;
						for22_exit384385: skip
					fi;
					for21_end385: skip
				};
				for21_exit385: skip
			:: else -> 
				do
				:: true -> 
					for21: skip;
					

					if
					:: stencil-1 != -3 -> 
												for(i : 0.. stencil-1) {
							for22: skip;
							

							if
							:: stencil-1 != -3 -> 
																for(i : 0.. stencil-1) {
									for23: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end: skip
								};
								for23_exit: skip
							:: else -> 
								do
								:: true -> 
									for23383: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end383: skip
								:: true -> 
									break
								od;
								for23_exit383: skip
							fi;
							for22_end: skip
						};
						for22_exit: skip
					:: else -> 
						do
						:: true -> 
							for22384: skip;
							

							if
							:: stencil-1 != -3 -> 
																for(i : 0.. stencil-1) {
									for23384: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end384: skip
								};
								for23_exit384: skip
							:: else -> 
								do
								:: true -> 
									for23383384: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end383384: skip
								:: true -> 
									break
								od;
								for23_exit383384: skip
							fi;
							for22_end384: skip
						:: true -> 
							break
						od;
						for22_exit384: skip
					fi;
					for21_end: skip
				:: true -> 
					break
				od;
				for21_exit: skip
			fi;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	send.closing!true;
	workerWG.Wait?0;
	ans.closing!true;
	stop_process: skip
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
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
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,ch.num_msgs -> // can always receive on a closed chan
		 ch.num_msgs = ch.num_msgs - 1
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!false,ch.num_msgs ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!false,ch.num_msgs
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
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
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
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

