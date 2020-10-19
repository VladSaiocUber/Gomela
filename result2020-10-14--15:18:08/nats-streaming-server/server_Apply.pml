#define Apply_op_PublishBatch_Messages  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example980510934/server/clustering.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Wgdef s_ioChannelWG;
	Wgdef s_wg;
	int op_PublishBatch_Messages = Apply_op_PublishBatch_Messages;
	bool state = false;
	run wgMonitor(s_wg);
	run wgMonitor(s_ioChannelWG);
	

	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			goto FATAL_ERROR
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
				
				if
				:: true -> 
					goto FATAL_ERROR
				:: true;
				fi
			:: true;
			fi
		:: true;
		fi;
				for(i : 1.. op_PublishBatch_Messages) {
for10:			
			if
			:: true -> 
				goto FATAL_ERROR
			:: true;
			fi
		};
		goto stop_process;
FATAL_ERROR:		
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi
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
