// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/pkg/volume/gcepd/attacher.go#L57
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewAttacher570 = [1] of {int};
	run NewAttacher57(child_NewAttacher570);
	run receiver(child_NewAttacher570)
stop_process:skip
}

proctype NewAttacher57(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef gceCloud_sharedResourceLock;
	Mutexdef gceCloud_nodeZonesLock;
	Mutexdef gceCloud_computeNodeTagLock;
	Mutexdef gceCloud_subnetworkURLAndIsLegacyNetworkInitializer_m;
	Mutexdef gceCloud_ClusterID_idLock;
	run mutexMonitor(gceCloud_ClusterID_idLock);
	run mutexMonitor(gceCloud_subnetworkURLAndIsLegacyNetworkInitializer_m);
	run mutexMonitor(gceCloud_computeNodeTagLock);
	run mutexMonitor(gceCloud_nodeZonesLock);
	run mutexMonitor(gceCloud_sharedResourceLock);
	

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

