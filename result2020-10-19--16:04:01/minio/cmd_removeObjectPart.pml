#define removeObjectPart_storageDisks  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example255495480/cmd/erasure-multipart.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef g_wg;
	int i;
	int storageDisks = removeObjectPart_storageDisks;
	bool state = false;
	run wgMonitor(g_wg);
		for(i : 1.. storageDisks) {
for10:
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
