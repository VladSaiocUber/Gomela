// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/rclone/rclone/blob/a223b78872dc7a8713ca2aa4596ae3e30c173cdd/backend/crypt/cipher_test.go#L784
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestNewEncrypterErrUnexpectedEOF7840 = [1] of {int};
	run TestNewEncrypterErrUnexpectedEOF784(child_TestNewEncrypterErrUnexpectedEOF7840);
	run receiver(child_TestNewEncrypterErrUnexpectedEOF7840)
stop_process:skip
}

proctype TestNewEncrypterErrUnexpectedEOF784(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef fh_mu;
	run mutexMonitor(fh_mu);
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

