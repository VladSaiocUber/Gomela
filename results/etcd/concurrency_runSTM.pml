#define lb_for154_0  -1
#define ub_for154_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [1] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run Anonymous0(_ch0);
	_ch0.in?0;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			break
		:: true;
		fi;
		
		if
		:: true -> 
			break
		:: true;
		fi
	od;
for10_exit:	_ch0.in!0;
	
	if
	:: true -> 
		_ch0.in!0
	:: true;
	fi;
stop_process:
}
