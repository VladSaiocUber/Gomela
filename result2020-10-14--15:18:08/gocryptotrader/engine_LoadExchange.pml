#define LoadExchange_assets  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example703110239/engine/exchange.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int assets = LoadExchange_assets;
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true -> 
		goto stop_process
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
	
	if
	:: true -> 
		
		if
		:: true -> 
						for(i : 1.. assets) {
for10:				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			}
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		Wgdef tempWG;
		run wgMonitor(tempWG);
		tempWG.Wait?0
	:: true -> 
		Wgdef tempWG;
		run wgMonitor(tempWG);
		tempWG.Wait?0
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
