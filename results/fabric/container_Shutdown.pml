
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [0] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
		for(i : 1.. r.containers) {
for10:		run Anonymous0(done)
	};
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	run Anonymous1(_ch0);
	do
	:: true -> 
		break
	:: _ch0.in?0 -> 
		break
	od
stop_process:}

proctype Anonymous0(Chandef done) {
	bool closed; 
	int i;
stop_process:
}
proctype Anonymous1(Chandef _ch0) {
	bool closed; 
	int i;
	_ch0.closing!true;
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
