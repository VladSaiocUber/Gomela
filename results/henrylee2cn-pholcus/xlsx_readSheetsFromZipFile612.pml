#define readSheetsFromZipFile_sheetCount  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example636483965/common/xlsx/lib.go
typedef Chandef {
	chan sync = [0] of {int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}



init { 
	Chandef sheetChan;
	bool state = false;
	int i;
	int sheetCount = readSheetsFromZipFile_sheetCount;
	

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
	:: sheetCount > 0 -> 
		sheetChan.size = sheetCount;
		run AsyncChan(sheetChan)
	:: else -> 
		run sync_monitor(sheetChan)
	fi;
	run go_Anonymous0(sheetChan);
	goto stop_process;
	sheetChan.closing!true
stop_process:skip
}

proctype go_Anonymous0(Chandef sheetChan) {
	bool closed; 
	int i;
	bool state;
	chan child_xlsxreadSheetFromFile0 = [0] of {int};
	chan child_xlsxreadSheetFromFile0 = [0] of {int};
	int workbookSheets = -2;
	

	if
	:: workbookSheets-1 != -3 -> 
				for(i : 0.. workbookSheets-1) {
			for20: skip;
			run xlsxreadSheetFromFile(sheetChan,child_xlsxreadSheetFromFile0);
			child_xlsxreadSheetFromFile0?0;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for20711: skip;
			run xlsxreadSheetFromFile(sheetChan,child_xlsxreadSheetFromFile0);
			child_xlsxreadSheetFromFile0?0;
			for20_end711: skip
		:: true -> 
			break
		od;
		for20_exit711: skip
	fi;
	stop_process: skip
}
proctype xlsxreadSheetFromFile(Chandef sc;chan child) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: true -> 
		

		if
		:: sc.async_send!0;
		:: sc.sync!0 -> 
			sc.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: sc.async_send!0;
	:: sc.sync!0 -> 
		sc.sending?0
	fi;
	stop_process: skip;
	

	if
	:: true -> 
		

		if
		:: sc.async_send!0;
		:: sc.sync!0 -> 
			sc.sending?0
		fi
	:: true;
	fi;
	child!0
}
proctype AsyncChan(Chandef ch) {
do
:: true ->
if
:: ch.closed -> 
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!0 ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false; // sending channel is open 
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.is_closed!false;
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!0
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false;  // sending channel is open
		  :: ch.sending!false;  // sending channel is open
		fi;
	fi;
fi;
od;
}

proctype sync_monitor(Chandef ch) {
do
:: true
if
:: ch.closed ->
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
    :: ch.is_closed!false ->
    fi;
fi;
od
stop_process:
}

