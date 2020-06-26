
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [0] of {int};
	chan _ch1_in = [0] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	_ch1.in = _ch1_in;
	run chanMonitor(_ch1);
	run Anonymous0(allowProgressIota,_ch1);
	do
	:: .in!0 -> 
		.sending?state;
		break
	:: _ch1.in?0 -> 
		goto stop_process
	od;
	do
	:: true -> 
for10:		.in!0;
		.sending?state
	od;
	.closing!true;
	_ch1.in?0;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef ;Chandef _ch1) {
	bool closed; 
	int i;
	_ch1.in!0;
	_ch1.sending?state;
stop_process:
}
proctype chanMonitor(Chandef ch) {
	bool closed; 
	int i;
	state = false;
	do
	:: true -> 
		if
		:: state -> 
end:			if
			:: ch.sending!state -> 
				assert(false)
			:: ch.closing?true -> 
				assert(false)
			:: ch.in!0;
			:: ch.is_closed!state;
			fi
		:: else -> 
end1:			if
			:: ch.sending!state;
			:: ch.closing?true -> 
				state = true
			:: ch.is_closed!state;
			fi
		fi
	od;
stop_process:
}
