#define waitForFilteredReplication_destinationShards  60
#define waitForFilteredReplication_si_SourceShards  60
#define waitForFilteredReplication_sourcePositions  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example994420206/go/vt/wrangler/keyspace.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int si_SourceShards = waitForFilteredReplication_si_SourceShards;
	Wgdef wg;
	int i;
	int destinationShards = waitForFilteredReplication_destinationShards;
	int sourcePositions = waitForFilteredReplication_sourcePositions;
	bool state = false;
	run wgMonitor(wg);
		for(i : 1.. destinationShards) {
for10:		wg.Add!1;
		run Anonymous0()
	};
	wg.Wait?0;
	goto stop_process
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	bool state;
		for(i : 1.. si_SourceShards) {
for11:				for(i : 1.. sourcePositions) {
for12:			
			if
			:: true -> 
				break
			:: true;
			fi
		};
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	};
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
