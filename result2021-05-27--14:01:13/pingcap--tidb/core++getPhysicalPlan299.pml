// num_comm_params=3
// num_mand_comm_params=0
// num_opt_comm_params=3

// git_link=https://github.com/pingcap/tidb/blob/207ce344cbb044ffb1b2681f1ba320a154979f6d/planner/core/common_plans.go#L299
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
	chan child_getPhysicalPlan2990 = [1] of {int};
	run getPhysicalPlan299(child_getPhysicalPlan2990);
	run receiver(child_getPhysicalPlan2990)
stop_process:skip
}

proctype getPhysicalPlan299(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef stmtCtx_RuntimeStatsColl_mu;
	Mutexdef stmtCtx_mu;
	Mutexdef sessVars_SequenceState_mu;
	Wgdef sessVars_BinlogClient_wg;
	Mutexdef sessVars_TxnCtx_tdmLock;
	Mutexdef sessVars_UsersLock;
	int cachedVal_TblInfo2UnionScan = -2; // opt cachedVal_TblInfo2UnionScan
	int cachedVals = -2; // opt cachedVals
	int e_UsingVars = -2; // opt e_UsingVars
	run mutexMonitor(sessVars_UsersLock);
	run mutexMonitor(sessVars_TxnCtx_tdmLock);
	run wgMonitor(sessVars_BinlogClient_wg);
	run mutexMonitor(sessVars_SequenceState_mu);
	run mutexMonitor(stmtCtx_mu);
	run mutexMonitor(stmtCtx_RuntimeStatsColl_mu);
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto REBUILD
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
	

	if
	:: true -> 
		

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
	fi;
	REBUILD: skip;
	

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

