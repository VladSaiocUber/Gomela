// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/packer/blob/a9c2283ee589b203c0ce16174a5747b7d2053d61/packer/provisioner_test.go#L258
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRetriedProvisionerProvision2580 = [1] of {int};
	run TestRetriedProvisionerProvision258(child_TestRetriedProvisionerProvision2580);
	run receiver(child_TestRetriedProvisionerProvision2580)
stop_process:skip
}

proctype TestRetriedProvisionerProvision258(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Provision1720 = [1] of {int};
	Mutexdef comm_StartCmd_m;
	Mutexdef ui_l;
	run mutexMonitor(ui_l);
	run mutexMonitor(comm_StartCmd_m);
	run Provision172(ui_l,comm_StartCmd_m,child_Provision1720);
	child_Provision1720?0;
	stop_process: skip;
	child!0
}
proctype Provision172(Mutexdef ui_l;Mutexdef comm_StartCmd_m;chan child) {
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

