// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/pkg/volume/glusterfs/glusterfs_minmax_test.go#L89
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAllocateNext890 = [1] of {int};
	run TestAllocateNext89(child_TestAllocateNext890);
	run receiver(child_TestAllocateNext890)
stop_process:skip
}

proctype TestAllocateNext89(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Free1852 = [1] of {int};
	chan child_Has1771 = [1] of {int};
	chan child_AllocateNext1310 = [1] of {int};
	Mutexdef m_lock;
	run mutexMonitor(m_lock);
	run AllocateNext131(m_lock,child_AllocateNext1310);
	child_AllocateNext1310?0;
	run Has177(m_lock,child_Has1771);
	child_Has1771?0;
	run Free185(m_lock,child_Free1852);
	child_Free1852?0;
	stop_process: skip;
	child!0
}
proctype AllocateNext131(Mutexdef a_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_has1711 = [1] of {int};
	chan child_has1710 = [1] of {int};
	int var_a_min = -2; // opt var_a_min
	int var_a_max = -2; // opt var_a_max
	a_lock.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: 0 != -2 && var_a_max != -2 -> 
				for(i : 0.. var_a_max) {
			for11: skip;
			run has171(a_lock,child_has1711);
			child_has1711?0;
			

			if
			:: true -> 
				goto defer1
			:: true;
			fi;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run has171(a_lock,child_has1710);
			child_has1710?0;
			

			if
			:: true -> 
				goto defer1
			:: true;
			fi;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	goto defer1;
		defer1: skip;
	a_lock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype has171(Mutexdef a_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Has177(Mutexdef a_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_has1711 = [1] of {int};
	a_lock.Lock!false;
	run has171(a_lock,child_has1711);
	child_has1711?0;
	goto defer1;
		defer1: skip;
	a_lock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Free185(Mutexdef a_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	a_lock.Lock!false;
	goto defer1;
		defer1: skip;
	a_lock.Unlock!false;
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

