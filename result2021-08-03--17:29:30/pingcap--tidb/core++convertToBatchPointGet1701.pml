// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/pingcap/tidb/blob/207ce344cbb044ffb1b2681f1ba320a154979f6d/planner/core/find_best_task.go#L1701
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
	chan child_convertToBatchPointGet17010 = [1] of {int};
	run convertToBatchPointGet1701(child_convertToBatchPointGet17010);
	run receiver(child_convertToBatchPointGet17010)
stop_process:skip
}

proctype convertToBatchPointGet1701(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef sessVars_SequenceState_mu;
	Wgdef sessVars_BinlogClient_wg;
	Mutexdef sessVars_TxnCtx_tdmLock;
	Mutexdef sessVars_UsersLock;
	int var_candidate_path_Ranges = -2; // opt var_candidate_path_Ranges
	

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
			run mutexMonitor(sessVars_UsersLock);
			run mutexMonitor(sessVars_TxnCtx_tdmLock);
			run wgMonitor(sessVars_BinlogClient_wg);
			run mutexMonitor(sessVars_SequenceState_mu)
		:: true;
		fi
	fi;
	goto stop_process;
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

