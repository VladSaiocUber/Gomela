
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example032656846/vfs/vfscache/item.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef downloaders_wg;
	int i;
	Wgdef item_downloaders_wg;
	bool state = false;
	run wgMonitor(downloaders_wg);
	run wgMonitor(item_downloaders_wg);
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
