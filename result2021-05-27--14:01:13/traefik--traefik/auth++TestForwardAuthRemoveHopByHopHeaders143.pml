// num_comm_params=2
// num_mand_comm_params=0
// num_opt_comm_params=2

// git_link=https://github.com/traefik/traefik/blob/080cf98e512f6fcb93838de76a6aa34ff147dee4/pkg/middlewares/auth/forward_test.go#L143
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestForwardAuthRemoveHopByHopHeaders1430 = [1] of {int};
	run TestForwardAuthRemoveHopByHopHeaders143(child_TestForwardAuthRemoveHopByHopHeaders1430);
	run receiver(child_TestForwardAuthRemoveHopByHopHeaders1430)
stop_process:skip
}

proctype TestForwardAuthRemoveHopByHopHeaders143(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef ts_mu;
	Wgdef ts_wg;
	Mutexdef ts_Config_mu;
	Mutexdef ts_TLS_mutex;
	Mutexdef authTs_mu;
	Wgdef authTs_wg;
	Mutexdef authTs_Config_mu;
	Mutexdef authTs_TLS_mutex;
	int forward_HopHeaders = -2; // opt forward_HopHeaders
	int hopHeaders = -2; // opt hopHeaders
	run mutexMonitor(authTs_TLS_mutex);
	run mutexMonitor(authTs_Config_mu);
	run wgMonitor(authTs_wg);
	run mutexMonitor(authTs_mu);
	run mutexMonitor(ts_TLS_mutex);
	run mutexMonitor(ts_Config_mu);
	run wgMonitor(ts_wg);
	run mutexMonitor(ts_mu);
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

proctype mutexMonitor(Mutexdef m) {
bool locked = false;
do
:: true ->
	if
	:: m.Counter > 0 ->
		if 
		:: m.RUnlock?false -> 
			m.Counter = m.Counter - 1;
		:: m.RLock?false -> 
			m.Counter = m.Counter + 1;
		fi;
	:: locked ->
		m.Unlock?false;
		locked = false;
	:: else ->	 end:	if
		:: m.Unlock?false ->
			assert(0==32);		:: m.Lock?false ->
			locked =true;
		:: m.RUnlock?false ->
			assert(0==32);		:: m.RLock?false ->
			m.Counter = m.Counter + 1;
		fi;
	fi;
od
}

proctype receiver(chan c) {
c?0
}

