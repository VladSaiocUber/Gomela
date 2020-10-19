
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example647550706/modules/ssh/ssh_graceful.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef srv_listenerWg;
	int i;
	Wgdef srv_connWg;
	bool state = false;
	run wgMonitor(srv_listenerWg);
	run wgMonitor(srv_connWg)
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
