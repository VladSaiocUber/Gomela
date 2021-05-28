// num_comm_params=6
// num_mand_comm_params=0
// num_opt_comm_params=6

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/pkg/kubelet/images/image_gc_manager_test.go#L343
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFreeSpaceTiesBrokenByDetectedTime3430 = [1] of {int};
	run TestFreeSpaceTiesBrokenByDetectedTime343(child_TestFreeSpaceTiesBrokenByDetectedTime3430);
	run receiver(child_TestFreeSpaceTiesBrokenByDetectedTime3430)
stop_process:skip
}

proctype TestFreeSpaceTiesBrokenByDetectedTime343(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_freeSpace3324 = [1] of {int};
	chan child_imageRecordsLen523 = [1] of {int};
	chan child_detectImages2092 = [1] of {int};
	chan child_detectImages2091 = [1] of {int};
	chan child_detectImages2090 = [1] of {int};
	Mutexdef manager_imageRecordsLock;
	run mutexMonitor(manager_imageRecordsLock);
	run detectImages209(manager_imageRecordsLock,child_detectImages2090);
	child_detectImages2090?0;
	run detectImages209(manager_imageRecordsLock,child_detectImages2091);
	child_detectImages2091?0;
	run detectImages209(manager_imageRecordsLock,child_detectImages2092);
	child_detectImages2092?0;
	run imageRecordsLen52(manager_imageRecordsLock,child_imageRecordsLen523);
	child_imageRecordsLen523?0;
	run freeSpace332(manager_imageRecordsLock,child_freeSpace3324);
	child_freeSpace3324?0;
	stop_process: skip;
	child!0
}
proctype detectImages209(Mutexdef im_imageRecordsLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int im_imageRecords = -2; // opt im_imageRecords
	int images = -2; // opt images
	int pod_Containers = -2; // opt pod_Containers
	int pods = -2; // opt pods
	

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
	im_imageRecordsLock.Lock!false;
	goto defer1;
		defer1: skip;
	im_imageRecordsLock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype imageRecordsLen52(Mutexdef im_imageRecordsLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	im_imageRecordsLock.Lock!false;
	goto defer1;
		defer1: skip;
	im_imageRecordsLock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype freeSpace332(Mutexdef im_imageRecordsLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_detectImages2094 = [1] of {int};
	int images = -2; // opt images
	int im_imageRecords = -2; // opt im_imageRecords
	run detectImages209(im_imageRecordsLock,child_detectImages2094);
	child_detectImages2094?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	im_imageRecordsLock.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	im_imageRecordsLock.Unlock!false;
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

