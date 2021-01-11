
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example173425768/tools/cache/testing/fake_controller_source.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef f_Broadcaster_distributing;
	bool state = false;
	int i;
	run wgMonitor(f_Broadcaster_distributing)
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

