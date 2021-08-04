// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/terraform/blob/c63c06d3c4d09a1bf1a1adc20216503e0cc2f881/states/statemgr/filesystem_test.go#L302
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFilesystem_lockUnlockWithoutWrite3020 = [1] of {int};
	run TestFilesystem_lockUnlockWithoutWrite302(child_TestFilesystem_lockUnlockWithoutWrite3020);
	run receiver(child_TestFilesystem_lockUnlockWithoutWrite3020)
stop_process:skip
}

proctype TestFilesystem_lockUnlockWithoutWrite302(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Unlock3281 = [1] of {int};
	chan child_Lock2960 = [1] of {int};
	Mutexdef ls_mu;
	run mutexMonitor(ls_mu);
	run Lock296(ls_mu,child_Lock2960);
	child_Lock2960?0;
	run Unlock328(ls_mu,child_Unlock3281);
	child_Unlock3281?0;
	

	if
	:: true -> 
		goto stop_process
	fi;
	stop_process: skip;
	child!0
}
proctype Lock296(Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_writeLockInfo5003 = [1] of {int};
	chan child_lockInfo4842 = [1] of {int};
	chan child_lock131 = [1] of {int};
	chan child_createStateFiles4330 = [1] of {int};
	

	if
	:: true -> 
		run createStateFiles433(s_mu,child_createStateFiles4330);
		child_createStateFiles4330?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run lock13(s_mu,child_lock131);
	child_lock131?0;
	

	if
	:: true -> 
		run lockInfo484(s_mu,child_lockInfo4842);
		child_lockInfo4842?0;
		goto stop_process
	:: true;
	fi;
	run writeLockInfo500(s_mu,child_writeLockInfo5003);
	child_writeLockInfo5003?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype createStateFiles433(Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype lock13(Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype lockInfo484(Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_lockInfoPath4702 = [1] of {int};
	run lockInfoPath470(s_mu,child_lockInfoPath4702);
	child_lockInfoPath4702?0;
	

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
proctype lockInfoPath470(Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype writeLockInfo500(Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_lockInfoPath4703 = [1] of {int};
	run lockInfoPath470(s_mu,child_lockInfoPath4703);
	child_lockInfoPath4703?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Unlock328(Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_unlock263 = [1] of {int};
	chan child_lockInfoPath4702 = [1] of {int};
	chan child_lockInfo4841 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run lockInfo484(s_mu,child_lockInfo4841);
		child_lockInfo4841?0;
		goto stop_process
	:: true;
	fi;
	run lockInfoPath470(s_mu,child_lockInfoPath4702);
	child_lockInfoPath4702?0;
	run unlock26(s_mu,child_unlock263);
	child_unlock263?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype unlock26(Mutexdef s_mu;chan child) {
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

