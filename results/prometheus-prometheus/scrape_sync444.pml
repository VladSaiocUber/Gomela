#define sync_sp_activeTargets  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example163393137/scrape/scrape.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	bool state = false;
	int i;
	int sp_activeTargets = sync_sp_activeTargets;
	run wgMonitor(wg);
		for(i : 0.. sp_activeTargets-1) {
		for20: skip;
		

		if
		:: true -> 
			wg.Add!1;
			run go_Anonymous0(wg)
		:: true;
		fi;
		for20_end: skip
	};
	for20_exit: skip;
	wg.Wait?0
stop_process:skip
}

proctype go_Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Add!-1;
	stop_process: skip
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

