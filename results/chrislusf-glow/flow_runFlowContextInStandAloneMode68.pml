#define runFlowContextInStandAloneMode_fc_Steps  3
#define runFlowContextInStandAloneMode_step_Inputs  1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example955981196/flow/context_run.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	bool state = false;
	int i;
	int step_Inputs = runFlowContextInStandAloneMode_step_Inputs;
	int fc_Steps = runFlowContextInStandAloneMode_fc_Steps;
	run wgMonitor(wg);
		for(i : 0.. fc_Steps-1) {
		for10: skip;
				for(i : 0.. step_Inputs-1) {
			for11: skip;
			

			if
			:: true -> 
				wg.Add!1;
				run go_Anonymous0(wg)
			:: true;
			fi;
			for11_end: skip
		};
		for11_exit: skip;
		wg.Add!1;
		run go_Anonymous1(wg);
		

		if
		:: true -> 
			

			if
			:: true -> 
				wg.Add!1;
				run go_Anonymous2(wg)
			:: true;
			fi
		:: true;
		fi;
		for10_end: skip
	};
	for10_exit: skip;
	wg.Wait?0
stop_process:skip
}

proctype go_Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous1(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous2(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
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

