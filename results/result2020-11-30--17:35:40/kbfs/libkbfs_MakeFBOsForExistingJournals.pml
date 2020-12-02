#define MakeFBOsForExistingJournals_j_tlfJournals  3

// /tmp/clone-example639689849/libkbfs/journal_server.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int j_tlfJournals = MakeFBOsForExistingJournals_j_tlfJournals;
	bool state = false;
	run wgMonitor(wg);
		for(i : 0.. j_tlfJournals-1) {
for10:		wg.Add!1;
		run Anonymous0(wg)
	};
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
stop_process:	wg.Add!-1
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
	od
}
