// num_comm_params=6
// num_mand_comm_params=0
// num_opt_comm_params=6

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/pkg/kubelet/volumemanager/populator/desired_state_of_world_populator_test.go#L288
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFindAndRemoveDeletedPodsWithActualState2880 = [1] of {int};
	run TestFindAndRemoveDeletedPodsWithActualState288(child_TestFindAndRemoveDeletedPodsWithActualState2880);
	run receiver(child_TestFindAndRemoveDeletedPodsWithActualState2880)
stop_process:skip
}

proctype TestFindAndRemoveDeletedPodsWithActualState288(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_findAndRemoveDeletedPods2162 = [1] of {int};
	chan child_findAndRemoveDeletedPods2161 = [1] of {int};
	chan child_findAndAddNewPods1900 = [1] of {int};
	Mutexdef dswp_volumePluginMgr_mutex;
	Mutexdef dswp_hasAddedPodsLock;
	run mutexMonitor(dswp_hasAddedPodsLock);
	run mutexMonitor(dswp_volumePluginMgr_mutex);
	run findAndAddNewPods190(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_findAndAddNewPods1900);
	child_findAndAddNewPods1900?0;
	run findAndRemoveDeletedPods216(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_findAndRemoveDeletedPods2161);
	child_findAndRemoveDeletedPods2161?0;
	run findAndRemoveDeletedPods216(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_findAndRemoveDeletedPods2162);
	child_findAndRemoveDeletedPods2162?0;
	stop_process: skip;
	child!0
}
proctype findAndAddNewPods190(Mutexdef dswp_hasAddedPodsLock;Mutexdef dswp_volumePluginMgr_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_processPodVolumes3071 = [1] of {int};
	chan child_isPodTerminated1800 = [1] of {int};
	chan child_processPodVolumes3073 = [1] of {int};
	chan child_isPodTerminated1802 = [1] of {int};
	int dswp_podManager_GetPods__ = -2; // opt dswp_podManager_GetPods__
	int dswp_actualStateOfWorld_GetMountedVolumes__ = -2; // opt dswp_actualStateOfWorld_GetMountedVolumes__
	

	if
	:: dswp_podManager_GetPods__-1 != -3 -> 
				for(i : 0.. dswp_podManager_GetPods__-1) {
			for20: skip;
			run isPodTerminated180(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_isPodTerminated1800);
			child_isPodTerminated1800?0;
			

			if
			:: true -> 
				goto for20_end
			:: true;
			fi;
			run processPodVolumes307(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_processPodVolumes3071);
			child_processPodVolumes3071?0;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for23: skip;
			run isPodTerminated180(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_isPodTerminated1802);
			child_isPodTerminated1802?0;
			

			if
			:: true -> 
				goto for23_end
			:: true;
			fi;
			run processPodVolumes307(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_processPodVolumes3073);
			child_processPodVolumes3073?0;
			for23_end: skip
		:: true -> 
			break
		od;
		for23_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype isPodTerminated180(Mutexdef dswp_hasAddedPodsLock;Mutexdef dswp_volumePluginMgr_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype processPodVolumes307(Mutexdef dswp_hasAddedPodsLock;Mutexdef dswp_volumePluginMgr_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_markPodProcessed4736 = [1] of {int};
	chan child_markPodProcessed4738 = [1] of {int};
	chan child_podHasBeenSeenOnce4637 = [1] of {int};
	chan child_checkVolumeFSResize3833 = [1] of {int};
	chan child_createVolumeSpec4932 = [1] of {int};
	chan child_checkVolumeFSResize3835 = [1] of {int};
	chan child_createVolumeSpec4934 = [1] of {int};
	chan child_podPreviouslyProcessed4451 = [1] of {int};
	int pod_Spec_Volumes = -2; // opt pod_Spec_Volumes
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run podPreviouslyProcessed445(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_podPreviouslyProcessed4451);
	child_podPreviouslyProcessed4451?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: pod_Spec_Volumes-1 != -3 -> 
				for(i : 0.. pod_Spec_Volumes-1) {
			for21: skip;
			

			if
			:: true -> 
				goto for21_end
			:: true;
			fi;
			run createVolumeSpec493(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_createVolumeSpec4932);
			child_createVolumeSpec4932?0;
			

			if
			:: true -> 
				goto for21_end
			:: true;
			fi;
			

			if
			:: true -> 
				run checkVolumeFSResize383(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_checkVolumeFSResize3833);
				child_checkVolumeFSResize3833?0
			:: true;
			fi;
			for21_end: skip
		};
		for21_exit: skip
	:: else -> 
		do
		:: true -> 
			for22: skip;
			

			if
			:: true -> 
				goto for22_end
			:: true;
			fi;
			run createVolumeSpec493(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_createVolumeSpec4934);
			child_createVolumeSpec4934?0;
			

			if
			:: true -> 
				goto for22_end
			:: true;
			fi;
			

			if
			:: true -> 
				run checkVolumeFSResize383(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_checkVolumeFSResize3835);
				child_checkVolumeFSResize3835?0
			:: true;
			fi;
			for22_end: skip
		:: true -> 
			break
		od;
		for22_exit: skip
	fi;
	

	if
	:: true -> 
		run markPodProcessed473(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_markPodProcessed4736);
		child_markPodProcessed4736?0
	:: true -> 
		run podHasBeenSeenOnce463(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_podHasBeenSeenOnce4637);
		child_podHasBeenSeenOnce4637?0;
		

		if
		:: true -> 
			run markPodProcessed473(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_markPodProcessed4738);
			child_markPodProcessed4738?0
		:: true;
		fi
	fi;
	stop_process: skip;
	child!0
}
proctype podPreviouslyProcessed445(Mutexdef dswp_hasAddedPodsLock;Mutexdef dswp_volumePluginMgr_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
		stop_process: skip;
	stop_process: skip;
	child!0
}
proctype createVolumeSpec493(Mutexdef dswp_hasAddedPodsLock;Mutexdef dswp_volumePluginMgr_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getPVSpec6453 = [1] of {int};
	chan child_getPVCExtractPV6102 = [1] of {int};
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		run getPVCExtractPV610(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_getPVCExtractPV6102);
		child_getPVCExtractPV6102?0;
		

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
		run getPVSpec645(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_getPVSpec6453);
		child_getPVSpec6453?0;
		

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
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
		

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
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getPVCExtractPV610(Mutexdef dswp_hasAddedPodsLock;Mutexdef dswp_volumePluginMgr_mutex;chan child) {
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
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

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
proctype getPVSpec645(Mutexdef dswp_hasAddedPodsLock;Mutexdef dswp_volumePluginMgr_mutex;chan child) {
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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype checkVolumeFSResize383(Mutexdef dswp_hasAddedPodsLock;Mutexdef dswp_volumePluginMgr_mutex;chan child) {
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
	stop_process: skip;
	child!0
}
proctype markPodProcessed473(Mutexdef dswp_hasAddedPodsLock;Mutexdef dswp_volumePluginMgr_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
		stop_process: skip;
	stop_process: skip;
	child!0
}
proctype podHasBeenSeenOnce463(Mutexdef dswp_hasAddedPodsLock;Mutexdef dswp_volumePluginMgr_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype findAndRemoveDeletedPods216(Mutexdef dswp_hasAddedPodsLock;Mutexdef dswp_volumePluginMgr_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_deleteProcessedPod4822 = [1] of {int};
	chan child_isPodTerminated1801 = [1] of {int};
	chan child_deleteProcessedPod4824 = [1] of {int};
	chan child_isPodTerminated1803 = [1] of {int};
	int podsWithError = -2; // opt podsWithError
	int runningPods = -2; // opt runningPods
	int dswp_desiredStateOfWorld_GetVolumesToMount__ = -2; // opt dswp_desiredStateOfWorld_GetVolumesToMount__
	

	if
	:: dswp_desiredStateOfWorld_GetVolumesToMount__-1 != -3 -> 
				for(i : 0.. dswp_desiredStateOfWorld_GetVolumesToMount__-1) {
			for30: skip;
			

			if
			:: true -> 
				

				if
				:: true -> 
					

					if
					:: true -> 
						goto for30_end
					:: true;
					fi
				:: true;
				fi;
				run isPodTerminated180(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_isPodTerminated1801);
				child_isPodTerminated1801?0;
				

				if
				:: true -> 
					goto for30_end
				:: true;
				fi;
				

				if
				:: true -> 
					goto for30_end
				:: true;
				fi
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: true -> 
					goto for30_end
				:: true;
				fi
			:: true;
			fi;
			

			if
			:: true -> 
				goto for32_end
			:: true;
			fi;
			

			if
			:: true -> 
				goto for32_end
			:: true;
			fi;
			run deleteProcessedPod482(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_deleteProcessedPod4822);
			child_deleteProcessedPod4822?0;
			for30_end: skip
		};
		for30_exit: skip
	:: else -> 
		do
		:: true -> 
			for33: skip;
			

			if
			:: true -> 
				

				if
				:: true -> 
					

					if
					:: true -> 
						goto for33_end
					:: true;
					fi
				:: true;
				fi;
				run isPodTerminated180(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_isPodTerminated1803);
				child_isPodTerminated1803?0;
				

				if
				:: true -> 
					goto for33_end
				:: true;
				fi;
				

				if
				:: true -> 
					goto for33_end
				:: true;
				fi
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: true -> 
					goto for33_end
				:: true;
				fi
			:: true;
			fi;
			

			if
			:: true -> 
				goto for35_end
			:: true;
			fi;
			

			if
			:: true -> 
				goto for35_end
			:: true;
			fi;
			run deleteProcessedPod482(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_deleteProcessedPod4824);
			child_deleteProcessedPod4824?0;
			for33_end: skip
		:: true -> 
			break
		od;
		for33_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype deleteProcessedPod482(Mutexdef dswp_hasAddedPodsLock;Mutexdef dswp_volumePluginMgr_mutex;chan child) {
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

