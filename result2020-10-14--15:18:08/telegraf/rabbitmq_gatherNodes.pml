#define gatherNodes_allNodes  60
#define gatherNodes_nodes  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example985353586/plugins/inputs/rabbitmq/rabbitmq.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int nodes = gatherNodes_nodes;
	Wgdef wg;
	bool state = false;
	int allNodes = gatherNodes_allNodes;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. allNodes) {
for10:
	};
	run wgMonitor(wg);
		for(i : 1.. nodes) {
for20:		wg.Add!1;
		run Anonymous0(wg)
	};
	wg.Wait?0
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	wg.Add!-1;
stop_process:
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
