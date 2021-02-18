#define execSelections_fields  1

// https://github.com/graph-gophers/graphql-go/blob/beb923fada293249384c7a9fa0c5078ea92466f3/internal/exec/exec.go#L71
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int fields = execSelections_fields;
	

	if
	:: true -> 
		run wgMonitor(wg);
		wg.Add!fields;
				for(i : 0.. fields-1) {
			for10: skip;
			run go_Anonymous0(wg);
			for10_end: skip
		};
		for10_exit: skip;
		wg.Wait?0
	fi
stop_process:skip
}

proctype go_Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	wg.Add!-1
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
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

