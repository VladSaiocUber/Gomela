// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/labstack/echo/blob/643066594d00891e3151c7ed87244bfeddcd57b9/bind_test.go#L389
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBindParam3890 = [1] of {int};
	run TestBindParam389(child_TestBindParam3890);
	run receiver(child_TestBindParam3890)
stop_process:skip
}

proctype TestBindParam389(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewContext3292 = [1] of {int};
	Mutexdef e2_AutoTLSManager_challengeMu;
	Mutexdef e2_AutoTLSManager_renewalMu;
	Mutexdef e2_AutoTLSManager_stateMu;
	Mutexdef e2_AutoTLSManager_clientMu;
	Mutexdef e2_TLSServer_mu;
	Mutexdef e2_Server_mu;
	Mutexdef e2_StdLogger_mu;
	Mutexdef e2_startupMutex;
	chan child_NewContext3291 = [1] of {int};
	chan child_NewContext3290 = [1] of {int};
	Mutexdef e_AutoTLSManager_challengeMu;
	Mutexdef e_AutoTLSManager_renewalMu;
	Mutexdef e_AutoTLSManager_stateMu;
	Mutexdef e_AutoTLSManager_clientMu;
	Mutexdef e_TLSServer_mu;
	Mutexdef e_Server_mu;
	Mutexdef e_StdLogger_mu;
	Mutexdef e_startupMutex;
	run mutexMonitor(e_startupMutex);
	run mutexMonitor(e_StdLogger_mu);
	run mutexMonitor(e_Server_mu);
	run mutexMonitor(e_TLSServer_mu);
	run mutexMonitor(e_AutoTLSManager_clientMu);
	run mutexMonitor(e_AutoTLSManager_stateMu);
	run mutexMonitor(e_AutoTLSManager_renewalMu);
	run mutexMonitor(e_AutoTLSManager_challengeMu);
	run NewContext329(e_AutoTLSManager_challengeMu,e_AutoTLSManager_clientMu,e_AutoTLSManager_renewalMu,e_AutoTLSManager_stateMu,e_Server_mu,e_StdLogger_mu,e_startupMutex,e_TLSServer_mu,child_NewContext3290);
	child_NewContext3290?0;
	run NewContext329(e_AutoTLSManager_challengeMu,e_AutoTLSManager_clientMu,e_AutoTLSManager_renewalMu,e_AutoTLSManager_stateMu,e_Server_mu,e_StdLogger_mu,e_startupMutex,e_TLSServer_mu,child_NewContext3291);
	child_NewContext3291?0;
	run mutexMonitor(e2_startupMutex);
	run mutexMonitor(e2_StdLogger_mu);
	run mutexMonitor(e2_Server_mu);
	run mutexMonitor(e2_TLSServer_mu);
	run mutexMonitor(e2_AutoTLSManager_clientMu);
	run mutexMonitor(e2_AutoTLSManager_stateMu);
	run mutexMonitor(e2_AutoTLSManager_renewalMu);
	run mutexMonitor(e2_AutoTLSManager_challengeMu);
	run NewContext329(e2_AutoTLSManager_challengeMu,e2_AutoTLSManager_clientMu,e2_AutoTLSManager_renewalMu,e2_AutoTLSManager_stateMu,e2_Server_mu,e2_StdLogger_mu,e2_startupMutex,e2_TLSServer_mu,child_NewContext3292);
	child_NewContext3292?0;
	stop_process: skip;
	child!0
}
proctype NewContext329(Mutexdef e_AutoTLSManager_challengeMu;Mutexdef e_AutoTLSManager_clientMu;Mutexdef e_AutoTLSManager_renewalMu;Mutexdef e_AutoTLSManager_stateMu;Mutexdef e_Server_mu;Mutexdef e_StdLogger_mu;Mutexdef e_startupMutex;Mutexdef e_TLSServer_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
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

