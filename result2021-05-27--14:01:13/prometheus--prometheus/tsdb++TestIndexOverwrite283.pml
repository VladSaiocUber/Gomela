// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/prometheus/prometheus/blob/27b78c336e436e9eed8b55ab0b162b888ec641d8/tsdb/exemplar_test.go#L283
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestIndexOverwrite2830 = [1] of {int};
	run TestIndexOverwrite283(child_TestIndexOverwrite2830);
	run receiver(child_TestIndexOverwrite2830)
stop_process:skip
}

proctype TestIndexOverwrite283(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AddExemplar1643 = [1] of {int};
	chan child_AddExemplar1642 = [1] of {int};
	chan child_AddExemplar1641 = [1] of {int};
	chan child_AddExemplar1640 = [1] of {int};
	Mutexdef es_lock;
	run mutexMonitor(es_lock);
	run AddExemplar164(es_lock,child_AddExemplar1640);
	child_AddExemplar1640?0;
	run AddExemplar164(es_lock,child_AddExemplar1641);
	child_AddExemplar1641?0;
	run AddExemplar164(es_lock,child_AddExemplar1642);
	child_AddExemplar1642?0;
	run AddExemplar164(es_lock,child_AddExemplar1643);
	child_AddExemplar1643?0;
	stop_process: skip;
	child!0
}
proctype AddExemplar164(Mutexdef ce_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	ce_lock.Lock!false;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto defer1
		:: true;
		fi;
		

		if
		:: true -> 
			goto defer1
		:: true;
		fi
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	ce_lock.Unlock!false;
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

