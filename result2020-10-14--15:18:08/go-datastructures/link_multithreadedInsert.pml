#define multithreadedInsert_chunks  60
#define multithreadedInsert_chunk  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example908394229/btree/_link/tree.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int chunks = multithreadedInsert_chunks;
	Wgdef wg;
	int chunk = multithreadedInsert_chunk;
	bool state = false;
	run wgMonitor(wg);
	wg.Add!chunks;
		for(i : 1.. chunks) {
for10:		run Anonymous0(wg)
	};
	wg.Wait?0;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: 0 != -1 && chunk-1 != -1 -> 
				for(i : 0.. chunk-1) {
for11:
		}
	:: else -> 
		do
		:: true -> 
for11:
		:: true -> 
			break
		od
	fi;
for11_exit:	wg.Add!-1;
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
