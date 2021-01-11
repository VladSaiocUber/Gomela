
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example485971155/server/cmd_migrate.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef _wg;
	Wgdef mc_wg;
	bool state = false;
	int i;
	run wgMonitor(mc_wg);
	

	if
	:: true -> 
		run wgMonitor(_wg)
	:: true;
	fi;
	goto stop_process
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

