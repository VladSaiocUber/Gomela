// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/jaegertracing/jaeger/blob/12bba8c9b91cf4a29d314934bc08f4a80e43c042/cmd/ingester/app/consumer/offset/concurrent_list_test.go#L87
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestMultipleInsertsAndResets870 = [1] of {int};
	run TestMultipleInsertsAndResets87(child_TestMultipleInsertsAndResets870);
	run receiver(child_TestMultipleInsertsAndResets870)
stop_process:skip
}

proctype TestMultipleInsertsAndResets87(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_setToHighestContiguous456 = [1] of {int};
	chan child_insert335 = [1] of {int};
	chan child_insert334 = [1] of {int};
	chan child_setToHighestContiguous453 = [1] of {int};
	chan child_insert332 = [1] of {int};
	chan child_insert331 = [1] of {int};
	chan child_insert330 = [1] of {int};
	Mutexdef l_mutex;
	run mutexMonitor(l_mutex);
	

	if
	:: 0 != -2 && 200-1 != -3 -> 
				for(i : 0.. 200-1) {
			for11: skip;
			run insert33(l_mutex,child_insert331);
			child_insert331?0;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run insert33(l_mutex,child_insert330);
			child_insert330?0;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	run insert33(l_mutex,child_insert332);
	child_insert332?0;
	run setToHighestContiguous45(l_mutex,child_setToHighestContiguous453);
	child_setToHighestContiguous453?0;
	

	if
	:: 0 != -2 && 99-1 != -3 -> 
				for(i : 0.. 99-1) {
			for31: skip;
			run insert33(l_mutex,child_insert335);
			child_insert335?0;
			for31_end: skip
		};
		for31_exit: skip
	:: else -> 
		do
		:: true -> 
			for30: skip;
			run insert33(l_mutex,child_insert334);
			child_insert334?0;
			for30_end: skip
		:: true -> 
			break
		od;
		for30_exit: skip
	fi;
	run setToHighestContiguous45(l_mutex,child_setToHighestContiguous456);
	child_setToHighestContiguous456?0;
	stop_process: skip;
	child!0
}
proctype insert33(Mutexdef s_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_mutex.Lock!false;
		defer1: skip;
	s_mutex.Unlock!false;
	stop_process: skip;
	child!0
}
proctype setToHighestContiguous45(Mutexdef s_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_offsets = -2; // opt var_offsets
	s_mutex.Lock!false;
	s_mutex.Unlock!false;
	s_mutex.Lock!false;
	s_mutex.Unlock!false;
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

