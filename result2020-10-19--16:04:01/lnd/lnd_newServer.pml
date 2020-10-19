#define newServer_listenAddrs  5
#define newServer_cfg_ExternalIPs  5
#define newServer_msgs  5
#define newServer_dbChannels  5
#define newServer_s_currentNodeAnn_Addresses  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example776713684/server.go
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
	Wgdef s_chanStatusMgr_wg;
	int msgs = newServer_msgs;
	Wgdef s_fundingMgr_wg;
	Wgdef s_wg;
	Wgdef s_utxoNursery_wg;
	Wgdef cmgr_wg;
	bool state = false;
	Wgdef s_htlcSwitch_wg;
	Wgdef s_authGossiper_wg;
	Wgdef s_chainArb_wg;
	Wgdef s_chanEventStore_wg;
	int listenAddrs = newServer_listenAddrs;
	int s_currentNodeAnn_Addresses = newServer_s_currentNodeAnn_Addresses;
	Wgdef replayLog_wg;
	Chandef s_quit;
	Wgdef chanStatusMgr_wg;
	Wgdef s_chanRouter_wg;
	Wgdef s_sweeper_wg;
	Chandef contractBreaches;
	Wgdef s_breachArbiter_wg;
	Wgdef s_chanSubSwapper_wg;
	Wgdef s_livelinessMonitor_wg;
	Wgdef s_connMgr_wg;
	int cfg_ExternalIPs = newServer_cfg_ExternalIPs;
	int dbChannels = newServer_dbChannels;
	int i;
		for(i : 1.. listenAddrs) {
for10:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	};
	run wgMonitor(replayLog_wg);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(s_wg);
	run sync_monitor(s_quit);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(s_htlcSwitch_wg);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(chanStatusMgr_wg);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(s_chanStatusMgr_wg);
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		fi
	:: true;
	fi;
		for(i : 1.. cfg_ExternalIPs) {
for20:
	};
	
	if
	:: true -> 
				for(i : 1.. listenAddrs) {
for30:
		}
	:: true;
	fi;
	
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
		goto stop_process
	:: true;
	fi;
	run wgMonitor(s_chanRouter_wg);
	
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
		goto stop_process
	:: true;
	fi;
	run wgMonitor(s_authGossiper_wg);
	
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
	run wgMonitor(s_sweeper_wg);
	run wgMonitor(s_utxoNursery_wg);
	
	if
	:: 1 > 0 -> 
		contractBreaches.size = 1;
		run emptyChan(contractBreaches)
	:: else -> 
		run sync_monitor(contractBreaches)
	fi;
	run wgMonitor(s_chainArb_wg);
	run wgMonitor(s_breachArbiter_wg);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(s_fundingMgr_wg);
	
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
	run wgMonitor(s_chanSubSwapper_wg);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(s_chanEventStore_wg);
	
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
		fi
	:: true;
	fi;
	
	if
	:: true -> 
				for(i : 1.. s_currentNodeAnn_Addresses) {
for40:
		};
		Wgdef s_hostAnn_wg;
		run wgMonitor(s_hostAnn_wg)
	:: true;
	fi;
	run wgMonitor(s_livelinessMonitor_wg);
	run wgMonitor(cmgr_wg);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(s_connMgr_wg);
	goto stop_process
stop_process:}

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

