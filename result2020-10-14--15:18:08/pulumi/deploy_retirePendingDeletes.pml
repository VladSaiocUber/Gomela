#define retirePendingDeletes_antichains  60
#define retirePendingDeletes_antichain  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example569128885/pkg/resource/deploy/plan_executor.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int antichain = retirePendingDeletes_antichain;
	Wgdef stepExec_workers;
	bool state = false;
	int antichains = retirePendingDeletes_antichains;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(stepExec_workers);
		for(i : 1.. antichains) {
for10:				for(i : 1.. antichain) {
for11:
		}
	};
	
	if
	:: true -> 
		goto stop_process
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	goto stop_process
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
