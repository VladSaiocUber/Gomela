#define chunkify_res_objects  60
#define chunkify_res_metrics  60
#define chunkify_timeBuckets  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example985353586/plugins/inputs/vsphere/endpoint.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int res_metrics = chunkify_res_metrics;
	Wgdef te_wg;
	int i;
	int res_objects = chunkify_res_objects;
	int timeBuckets = chunkify_timeBuckets;
	bool state = false;
	run wgMonitor(te_wg);
		for(i : 1.. res_objects) {
for10:				for(i : 1.. res_metrics) {
for11:			
			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true;
			fi
		};
				for(i : 1.. timeBuckets) {
for12:
		}
	}
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
