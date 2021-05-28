// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/ethereum/go-ethereum/blob/b8040a430e34117f121c67e8deee4a5e889e8372/log/syslog.go#L12
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_SyslogHandler120 = [1] of {int};
	run SyslogHandler12(child_SyslogHandler120);
	run receiver(child_SyslogHandler120)
stop_process:skip
}

proctype SyslogHandler12(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_sharedSyslog240 = [1] of {int};
	Mutexdef wr_mu;
	run mutexMonitor(wr_mu);
	run sharedSyslog24(wr_mu,child_sharedSyslog240);
	child_sharedSyslog240?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype sharedSyslog24(Mutexdef sysWr_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype mutexMonitor(Mutexdef m) {
bool locked = false;
do
:: true ->
	if
	:: m.Counter > 0 ->
		if 
		:: m.RUnlock?false -> 
			m.Counter = m.Counter - 1;
		:: m.RLock?false -> 
			m.Counter = m.Counter + 1;
		fi;
	:: locked ->
		m.Unlock?false;
		locked = false;
	:: else ->	 end:	if
		:: m.Unlock?false ->
			assert(0==32);		:: m.Lock?false ->
			locked =true;
		:: m.RUnlock?false ->
			assert(0==32);		:: m.RLock?false ->
			m.Counter = m.Counter + 1;
		fi;
	fi;
od
}

proctype receiver(chan c) {
c?0
}

