
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [3] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	do
	:: true -> 
		do
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		od;
		break
	:: true -> 
		break
	od;
	
	if
	:: true -> 
		
		if
		:: true -> 
			do
			:: true -> 
				goto stop_process
			:: true -> 
				break
			od
		:: true;
		fi
	:: true;
	fi;
	_ch0.in = _ch0_in;
	run Anonymous0(_ch0);
	run Anonymous1(_ch0);
	run Anonymous2(_ch0);
	_ch0.in?0;
	run Anonymous3(_ch0);
	do
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	od
stop_process:}

proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	_ch0.in!0;
stop_process:
}
proctype Anonymous1(Chandef _ch0) {
	bool closed; 
	int i;
	_ch0.in!0;
stop_process:
}
proctype Anonymous2(Chandef _ch0) {
	bool closed; 
	int i;
	do
	:: true -> 
		break
	:: true -> 
		break
	:: true -> 
		break
	od;
	_ch0.in!0;
stop_process:
}
proctype Anonymous3(Chandef _ch0) {
	bool closed; 
	int i;
	_ch0.in?0;
	_ch0.in?0;
stop_process:
}
