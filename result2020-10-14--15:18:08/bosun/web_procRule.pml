#define procRule_rh_Events  60
#define procRule_keys  60
#define procRule_errs  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example035891773/cmd/bosun/web/expr.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int keys = procRule_keys;
	Wgdef s_checksRunning;
	int i;
	int rh_Events = procRule_rh_Events;
	int errs = procRule_errs;
	bool state = false;
	run wgMonitor(s_checksRunning);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. rh_Events) {
for10:		

		if
		:: true;
		:: true;
		:: true;
		:: true -> 
			goto stop_process
		fi
	};
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
						for(i : 1.. keys) {
for20:				
				if
				:: true -> 
					break
				:: true;
				fi
			}
		:: true;
		fi;
				for(i : 1.. errs) {
for30:
		};
		
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
	:: true;
	fi;
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
