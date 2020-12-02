#define SetReference_concurrentWorkers  3
#define SetReference_conf_Imports  3
#define SetReference_conf_DevImports  1
#define lb_for29_3  -1
#define ub_for29_4  -1

// /tmp/clone-example900197216/repo/set_reference.go
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
	bool state = false;
	int concurrentWorkers = SetReference_concurrentWorkers;
	Chandef in;
	int conf_DevImports = SetReference_conf_DevImports;
	Chandef done;
	Wgdef wg;
	int conf_Imports = SetReference_conf_Imports;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: concurrentWorkers > 0 -> 
		done.size = concurrentWorkers;
		run AsyncChan(done)
	:: else -> 
		run sync_monitor(done)
	fi;
	
	if
	:: concurrentWorkers > 0 -> 
		in.size = concurrentWorkers;
		run AsyncChan(in)
	:: else -> 
		run sync_monitor(in)
	fi;
	run wgMonitor(wg);
for10_exit:		for(i : 0.. conf_Imports-1) {
for20:		
		if
		:: true -> 
			wg.Add!1;
			
			if
			:: in.async_send!0;
			:: in.sync!0 -> 
				in.sending?0
			fi
		:: true;
		fi
	};
	
	if
	:: true -> 
				for(i : 0.. conf_DevImports-1) {
for30:			
			if
			:: true -> 
				wg.Add!1;
				
				if
				:: in.async_send!0;
				:: in.sync!0 -> 
					in.sending?0
				fi
			:: true;
			fi
		}
	:: true;
	fi;
	wg.Wait?0;
	
	if
	:: 0 != -2 && concurrentWorkers-1 != -3 -> 
				for(i : 0.. concurrentWorkers-1) {
for40:			
			if
			:: done.async_send!0;
			:: done.sync!0 -> 
				done.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for40:			
			if
			:: done.async_send!0;
			:: done.sync!0 -> 
				done.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for40_exit:	goto stop_process
stop_process:}

proctype Anonymous0(Chandef ch;Chandef done;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for11:		do
		:: ch.async_rcv?0 -> 
			wg.Add!-1;
			break
		:: ch.sync?0 -> 
			wg.Add!-1;
			break
		:: done.async_rcv?0 -> 
			goto stop_process
		:: done.sync?0 -> 
			goto stop_process
		od
	od;
for11_exit:stop_process:
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
	od
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

