#define getVendorNVMeAttributes_NVMeDevices  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example266662108/plugins/inputs/smart/smart.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	bool state = false;
	int i;
	int NVMeDevices = getVendorNVMeAttributes_NVMeDevices;
	run wgMonitor(wg);
		for(i : 0.. NVMeDevices-1) {
		for10: skip;
		

		if
		:: true -> 
			

			if
			:: true -> 
				wg.Add!1;
				run go_gatherIntelNVMeDisk(wg)
			:: true;
			fi
		fi;
		for10_end: skip
	};
	for10_exit: skip;
	wg.Wait?0
stop_process:skip
}

proctype go_gatherIntelNVMeDisk(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	wg.Add!-1
}
proctype wgMonitor(Wgdef wg) {
bool closed;
int i;
bool state;
do
	:: wg.Add?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.Add?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
	fi
od
}

