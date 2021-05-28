// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/rclone/rclone/blob/6ef7178ee4465f2361b6e2cf483cef5bbfd9c95c/lib/cache/cache_test.go#L204
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestClear2040 = [1] of {int};
	run TestClear204(child_TestClear2040);
	run receiver(child_TestClear2040)
stop_process:skip
}

proctype TestClear204(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Clear2191 = [1] of {int};
	chan child_Get810 = [1] of {int};
	Mutexdef c_mu;
	run mutexMonitor(c_mu);
	run Get81(c_mu,child_Get810);
	child_Get810?0;
	run Clear219(c_mu,child_Clear2191);
	child_Clear2191?0;
	stop_process: skip;
	child!0
}
proctype Get81(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_used711 = [1] of {int};
	chan child_noCache400 = [1] of {int};
	c_mu.Lock!false;
	

	if
	:: true -> 
		c_mu.Unlock!false;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		c_mu.Lock!false;
		run noCache40(c_mu,child_noCache400);
		child_noCache400?0
	:: true;
	fi;
	run used71(c_mu,child_used711);
	child_used711?0;
	goto defer1;
		defer1: skip;
	c_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype noCache40(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype used71(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype Clear219(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int c_cache = -2; // opt c_cache
	c_mu.Lock!false;
	c_mu.Unlock!false;
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

