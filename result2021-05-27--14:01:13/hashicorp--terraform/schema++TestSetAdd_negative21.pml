// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/hashicorp/terraform/blob/c63c06d3c4d09a1bf1a1adc20216503e0cc2f881/internal/legacy/helper/schema/set_test.go#L21
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestSetAdd_negative210 = [1] of {int};
	run TestSetAdd_negative21(child_TestSetAdd_negative210);
	run receiver(child_TestSetAdd_negative210)
stop_process:skip
}

proctype TestSetAdd_negative21(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_List982 = [1] of {int};
	chan child_Add741 = [1] of {int};
	chan child_Add740 = [1] of {int};
	Mutexdef s_once_m;
	run mutexMonitor(s_once_m);
	run Add74(s_once_m,child_Add740);
	child_Add740?0;
	run Add74(s_once_m,child_Add741);
	child_Add741?0;
	run List98(s_once_m,child_List982);
	child_List982?0;
	stop_process: skip;
	child!0
}
proctype Add74(Mutexdef s_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_add1950 = [1] of {int};
	run add195(s_once_m,child_add1950);
	child_add1950?0;
	stop_process: skip;
	child!0
}
proctype add195(Mutexdef s_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_hash2200 = [1] of {int};
	run hash220(s_once_m,child_hash2200);
	child_hash2200?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype hash220(Mutexdef s_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype List98(Mutexdef s_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int s_listCode__ = -2; // opt s_listCode__
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

