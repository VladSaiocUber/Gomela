
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [1] of {int};
	chan _ch2_in = [1] of {int};
	bool state = false;
	chan _ch1_in = [1] of {int};
	int i;
	Chandef _ch2;
	Chandef _ch1;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	run Anonymous0(_ch0,uc,mcc);
	_ch1.in = _ch1_in;
	run chanMonitor(_ch1);
	run Anonymous1(_ch0,_ch1,mcc);
	_ch2.in = _ch2_in;
	run chanMonitor(_ch2);
	run Anonymous2(_ch0,_ch1,_ch2);
	_ch0.in?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	_ch1.in?0;
	
	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		fi
	:: true;
	fi;
	_ch2.in?0;
	
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
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef _ch0;Chandef uc;Chandef mcc) {
	bool closed; 
	int i;
	_ch0.in!0;
	_ch0.sending?state;
	_ch0.closing!true;
stop_process:
}
proctype Anonymous1(Chandef _ch0;Chandef _ch1;Chandef mcc) {
	bool closed; 
	int i;
	_ch1.in!0;
	_ch1.sending?state;
	_ch1.closing!true;
stop_process:
}
proctype Anonymous2(Chandef _ch0;Chandef _ch1;Chandef _ch2) {
	bool closed; 
	int i;
	_ch2.in!0;
	_ch2.sending?state;
	_ch2.closing!true;
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
