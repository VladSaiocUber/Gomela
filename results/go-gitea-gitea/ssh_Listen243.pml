
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example133053963/modules/ssh/ssh.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef srv_connWg;
	Wgdef srv_listenerWg;
	bool state = false;
	int i;
	run wgMonitor(srv_listenerWg);
	run wgMonitor(srv_connWg)
stop_process:skip
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

