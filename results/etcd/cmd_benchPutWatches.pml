#define clients  ??

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [clients] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	
	if
	:: 0 != -1 && watchPutTotal-1 != -1 -> 
				for(i : 0.. watchPutTotal-1) {
for10:
		}
	:: else -> 
		do
		:: true -> 
for10:
		:: true -> 
			break
		od
	fi;
for10_exit:	do
	:: true -> 
for20:		run Anonymous0(putreqc)
	od;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	run Anonymous2(_ch0);
	do
	:: true -> 
for40:		run Anonymous3(_ch0)
	od;
	r_Results__.closing!true
stop_process:}

proctype cmdrecvWatchChan3(chan child) {
	bool closed; 
	int i;
	do
	:: true -> 
for21:		do
		:: true -> 
for22:			results.in!0;
			results.sending?state;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		od
	od;
	child!0;
stop_process:
}
proctype Anonymous0(Chandef putreqc) {
	bool closed; 
	int i;
	chan child_cmdrecvWatchChan30 = [0] of {int};
	run cmdrecvWatchChan3(child_cmdrecvWatchChan30);
	child_cmdrecvWatchChan30?0;
stop_process:
}
proctype Anonymous2(Chandef _ch0) {
	bool closed; 
	int i;
	
	if
	:: 0 != -1 && watchPutTotal-1 != -1 -> 
				for(i : 0.. watchPutTotal-1) {
for30:			_ch0.in!0;
			_ch0.sending?state
		}
	:: else -> 
		do
		:: true -> 
for30:			_ch0.in!0;
			_ch0.sending?state
		:: true -> 
			break
		od
	fi;
for30_exit:	_ch0.closing!true;
stop_process:
}
proctype Anonymous3(Chandef _ch0) {
	bool closed; 
	int i;
	do
	:: _ch0.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			_ch0.in?0
		fi
	od;
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
