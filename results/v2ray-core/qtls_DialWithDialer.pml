
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		Chandef _ch0;
		chan _ch0_in = [2] of {int};
		_ch0.in = _ch0_in
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		run Anonymous0(_ch0)
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	errChannel.in!0;
stop_process:
}
