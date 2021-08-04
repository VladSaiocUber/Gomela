// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/wtfutil/wtf/blob/91942b68f203aa95e43dfa637165f0136a9343da/modules/security/users.go#L52
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_loggedInUsersLinux520 = [1] of {int};
	run loggedInUsersLinux52(child_loggedInUsersLinux520);
	run receiver(child_loggedInUsersLinux520)
stop_process:skip
}

proctype loggedInUsersLinux52(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ExecuteCommand490 = [1] of {int};
	Mutexdef cmd_Process_sigMu;
	int var_cleaned = -2; // opt var_cleaned
	int var_strings_Split = -2; // opt var_strings_Split
	run mutexMonitor(cmd_Process_sigMu);
	run ExecuteCommand49(cmd_Process_sigMu,child_ExecuteCommand490);
	child_ExecuteCommand490?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype ExecuteCommand49(Mutexdef cmd_Process_sigMu;chan child) {
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

