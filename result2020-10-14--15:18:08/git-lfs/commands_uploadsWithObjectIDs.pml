#define uploadsWithObjectIDs_oids  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example965297086/commands/command_push.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int oids = uploadsWithObjectIDs_oids;
	Wgdef q_collectorWait;
	bool state = false;
	Wgdef q_errorwait;
	int i;
		for(i : 1.. oids) {
for10:
	};
	run wgMonitor(q_collectorWait);
	run wgMonitor(q_errorwait)
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
