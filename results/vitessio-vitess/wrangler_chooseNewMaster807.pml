#define chooseNewMaster_tabletMap  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example245190199/go/vt/wrangler/reparent.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef maxPosSearch_waitGroup;
	bool state = false;
	int i;
	int tabletMap = chooseNewMaster_tabletMap;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(maxPosSearch_waitGroup);
		for(i : 0.. tabletMap-1) {
		for10: skip;
		

		if
		:: true -> 
			goto for10_end
		:: true;
		fi;
		maxPosSearch_waitGroup.Add!1;
		for10_end: skip
	};
	for10_exit: skip;
	maxPosSearch_waitGroup.Wait?0;
	

	if
	:: true -> 
		goto stop_process
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

