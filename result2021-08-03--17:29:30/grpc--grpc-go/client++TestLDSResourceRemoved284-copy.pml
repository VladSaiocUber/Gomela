// num_comm_params=3
// num_mand_comm_params=0
// num_opt_comm_params=3

// git_link=https://github.com/grpc/grpc-go/blob/ebd6aba6754d073a696e5727158cd0c917ce1019/xds/internal/client/watchers_listener_test.go#L284
#define not_found_320  -2 // opt updates line 77
#define not_found_332  -2 // opt updates line 77
#define not_found_345  -2 // opt updates line 77
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestLDSResourceRemoved2840 = [1] of {int};
	run TestLDSResourceRemoved284(child_TestLDSResourceRemoved2840);
	run receiver(child_TestLDSResourceRemoved2840)
stop_process:skip
}

proctype TestLDSResourceRemoved284(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close6210 = [1] of {int};
	chan child_NewListeners775 = [1] of {int};
	chan child_NewListeners774 = [1] of {int};
	chan child_NewListeners773 = [1] of {int};
	chan child_WatchListener2232 = [1] of {int};
	chan child_WatchListener2231 = [1] of {int};
	Mutexdef client_lrsMu;
	Mutexdef client_mu;
	Mutexdef client_updateCh_mu;
	Mutexdef client_cc_lceMu;
	Mutexdef client_cc_mu;
	run mutexMonitor(client_cc_mu);
	run mutexMonitor(client_cc_lceMu);
	run mutexMonitor(client_updateCh_mu);
	run mutexMonitor(client_mu);
	run mutexMonitor(client_lrsMu);
	run WatchListener223(client_cc_lceMu,client_cc_mu,client_lrsMu,client_mu,client_updateCh_mu,child_WatchListener2231);
	child_WatchListener2231?0;
	run WatchListener223(client_cc_lceMu,client_cc_mu,client_lrsMu,client_mu,client_updateCh_mu,child_WatchListener2232);
	child_WatchListener2232?0;
	run NewListeners77(client_cc_lceMu,client_cc_mu,client_lrsMu,client_mu,client_updateCh_mu,not_found_320,child_NewListeners773);
	child_NewListeners773?0;
	run NewListeners77(client_cc_lceMu,client_cc_mu,client_lrsMu,client_mu,client_updateCh_mu,not_found_332,child_NewListeners774);
	child_NewListeners774?0;
	run NewListeners77(client_cc_lceMu,client_cc_mu,client_lrsMu,client_mu,client_updateCh_mu,not_found_345,child_NewListeners775);
	child_NewListeners775?0;
		defer1: skip;
	run Close621(client_cc_lceMu,client_cc_mu,client_lrsMu,client_mu,client_updateCh_mu,child_Close6210);
	child_Close6210?0;
	stop_process: skip;
	child!0
}
proctype Close621(Mutexdef c_cc_lceMu;Mutexdef c_cc_mu;Mutexdef c_lrsMu;Mutexdef c_mu;Mutexdef c_updateCh_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype WatchListener223(Mutexdef c_cc_lceMu;Mutexdef c_cc_mu;Mutexdef c_lrsMu;Mutexdef c_mu;Mutexdef c_updateCh_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_watch1161 = [1] of {int};
	Mutexdef wi_mu;
	Mutexdef wi_c_lrsMu;
	Mutexdef wi_c_mu;
	run mutexMonitor(wi_c_mu);
	run mutexMonitor(wi_c_lrsMu);
	run mutexMonitor(wi_mu);
	run watch116(c_cc_lceMu,c_cc_mu,c_lrsMu,c_mu,c_updateCh_mu,wi_c_lrsMu,wi_c_mu,wi_mu,child_watch1161);
	child_watch1161?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype watch116(Mutexdef c_cc_lceMu;Mutexdef c_cc_mu;Mutexdef c_lrsMu;Mutexdef c_mu;Mutexdef c_updateCh_mu;Mutexdef wi_c_lrsMu;Mutexdef wi_c_mu;Mutexdef wi_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_newUpdate561 = [1] of {int};
	chan child_newUpdate562 = [1] of {int};
	chan child_newUpdate563 = [1] of {int};
	chan child_newUpdate564 = [1] of {int};
	c_mu.Lock!false;
	

	if
	:: true;
	:: true;
	:: true;
	:: true;
	:: true -> 
		goto defer1
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			run newUpdate56(wi_c_lrsMu,wi_c_mu,wi_mu,child_newUpdate561);
			child_newUpdate561?0
		:: true;
		fi
	:: true -> 
		

		if
		:: true -> 
			run newUpdate56(wi_c_lrsMu,wi_c_mu,wi_mu,child_newUpdate562);
			child_newUpdate562?0
		:: true;
		fi
	:: true -> 
		

		if
		:: true -> 
			run newUpdate56(wi_c_lrsMu,wi_c_mu,wi_mu,child_newUpdate563);
			child_newUpdate563?0
		:: true;
		fi
	:: true -> 
		

		if
		:: true -> 
			run newUpdate56(wi_c_lrsMu,wi_c_mu,wi_mu,child_newUpdate564);
			child_newUpdate564?0
		:: true;
		fi
	fi;
	goto defer1;
		defer1: skip;
	c_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype newUpdate56(Mutexdef wi_c_lrsMu;Mutexdef wi_c_mu;Mutexdef wi_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_scheduleCallback291 = [1] of {int};
	wi_mu.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	run scheduleCallback29(wi_c_lrsMu,wi_c_mu,wi_c_lrsMu,wi_c_mu,wi_mu,child_scheduleCallback291);
	child_scheduleCallback291?0;
		defer1: skip;
	wi_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype scheduleCallback29(Mutexdef c_lrsMu;Mutexdef c_mu;Mutexdef wi_c_lrsMu;Mutexdef wi_c_mu;Mutexdef wi_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype NewListeners77(Mutexdef c_cc_lceMu;Mutexdef c_cc_mu;Mutexdef c_lrsMu;Mutexdef c_mu;Mutexdef c_updateCh_mu;int var_updates;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_c_ldsCache = -2; // opt var_c_ldsCache
	int var_s = -2; // opt var_s
	c_mu.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
		defer1: skip;
	c_mu.Unlock!false;
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

