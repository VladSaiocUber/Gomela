#define Gather_d_Domains  1
#define Gather_d_Servers  1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example266662108/plugins/inputs/dns_query/dns_query.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	bool state = false;
	int i;
	int d_Servers = Gather_d_Servers;
	int d_Domains = Gather_d_Domains;
	run wgMonitor(wg);
		for(i : 0.. d_Domains-1) {
		for10: skip;
				for(i : 0.. d_Servers-1) {
			for11: skip;
			wg.Add!1;
			run go_Anonymous0(wg);
			for11_end: skip
		};
		for11_exit: skip;
		for10_end: skip
	};
	for10_exit: skip;
	wg.Wait?0;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Add!-1;
	stop_process: skip
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

