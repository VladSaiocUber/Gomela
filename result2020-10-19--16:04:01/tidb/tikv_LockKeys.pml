#define LockKeys_keysInput  5
#define LockKeys_keys  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example730203764/store/tikv/txn.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int keys = LockKeys_keys;
	int keysInput = LockKeys_keysInput;
	int i;
		for(i : 1.. keysInput) {
for10:		
		if
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true;
			fi
		fi
	};
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			Wgdef txn_committer_cleanWg;
			run wgMonitor(txn_committer_cleanWg);
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
		
		if
		:: true -> 
						for(i : 1.. keys) {
for20:
			};
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
		for(i : 1.. keys) {
for30:
	};
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
