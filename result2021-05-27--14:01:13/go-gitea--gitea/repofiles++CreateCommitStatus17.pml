// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/go-gitea/gitea/blob/ed393779004335a0afcca0dfac48937db41fabd6/modules/repofiles/commit_status.go#L17
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_CreateCommitStatus170 = [1] of {int};
	run CreateCommitStatus17(child_CreateCommitStatus170);
	run receiver(child_CreateCommitStatus170)
stop_process:skip
}

proctype CreateCommitStatus17(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close422 = [1] of {int};
	chan child_Close421 = [1] of {int};
	chan child_GetCommit3400 = [1] of {int};
	Mutexdef __submoduleCache_lock;
	Mutexdef gitRepo_tagCache_lock;
	run mutexMonitor(gitRepo_tagCache_lock);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(__submoduleCache_lock);
	run GetCommit340(gitRepo_tagCache_lock,child_GetCommit3400);
	child_GetCommit3400?0;
	

	if
	:: true -> 
		run Close42(gitRepo_tagCache_lock,child_Close421);
		child_Close421?0;
		goto stop_process
	:: true;
	fi;
	run Close42(gitRepo_tagCache_lock,child_Close422);
	child_Close422?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype GetCommit340(Mutexdef t_tagCache_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Close42(Mutexdef t_tagCache_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
		stop_process: skip;
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

