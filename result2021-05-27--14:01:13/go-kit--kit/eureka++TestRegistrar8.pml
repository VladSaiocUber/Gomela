// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/go-kit/kit/blob/60e8424101af501c525efaf67c0a2edf08667f80/sd/eureka/registrar_test.go#L8
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRegistrar80 = [1] of {int};
	run TestRegistrar8(child_TestRegistrar80);
	run receiver(child_TestRegistrar80)
stop_process:skip
}

proctype TestRegistrar8(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewRegistrar501 = [1] of {int};
	chan child_NewRegistrar500 = [1] of {int};
	Mutexdef connection_mu;
	run mutexMonitor(connection_mu);
	run NewRegistrar50(connection_mu,child_NewRegistrar500);
	child_NewRegistrar500?0;
	run NewRegistrar50(connection_mu,child_NewRegistrar501);
	child_NewRegistrar501?0;
	stop_process: skip;
	child!0
}
proctype NewRegistrar50(Mutexdef conn_mu;chan child) {
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

