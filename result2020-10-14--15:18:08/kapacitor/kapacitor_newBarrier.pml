
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example832332134/barrier.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int i;
	

	if
	:: true -> 
		Wgdef idleBarrier_wg;
		run wgMonitor(idleBarrier_wg);
		goto stop_process
	:: true -> 
		Wgdef periodicBarrier_wg;
		run wgMonitor(periodicBarrier_wg);
		goto stop_process
	:: true -> 
		goto stop_process
	fi
stop_process:}

proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: wg.Add?i -> 
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 -> 
end:		
		if
		:: wg.Add?i -> 
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
		fi
	od;
stop_process:
}
