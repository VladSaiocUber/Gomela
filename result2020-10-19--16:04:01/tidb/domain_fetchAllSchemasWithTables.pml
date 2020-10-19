#define fetchAllSchemasWithTables_splittedSchemas  5
#define fetchAllSchemasWithTables_schemas  5
#define fetchSchemasWithTables_tables  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example730203764/domain/domain.go
typedef Chandef {
	chan sync = [0] of {int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
}



init { 
	int schemas = fetchAllSchemasWithTables_schemas;
	Chandef doneCh;
	bool state = false;
	int splittedSchemas = fetchAllSchemasWithTables_splittedSchemas;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: splittedSchemas > 0 -> 
		doneCh.size = splittedSchemas;
		run emptyChan(doneCh)
	:: else -> 
		run sync_monitor(doneCh)
	fi;
		for(i : 1.. splittedSchemas) {
for10:		run go_dofetchSchemasWithTables(doneCh,schemas)
	};
		for(i : 1.. splittedSchemas) {
for20:		
		if
		:: doneCh.async_rcv?0;
		:: doneCh.sync?0;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	};
	goto stop_process
stop_process:}

proctype go_dofetchSchemasWithTables(Chandef done;int schemas) {
	bool closed; 
	int i;
	bool state;
		for(i : 1.. schemas) {
for11:		
		if
		:: true -> 
			
			if
			:: done.async_send!0;
			:: done.sync!0 -> 
				done.sending?0
			fi;
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
						for(i : 1.. tables) {
for12:
			}
		:: true;
		fi;
				for(i : 1.. tables) {
for13:
		}
	};
	
	if
	:: done.async_send!0;
	:: done.sync!0 -> 
		done.sending?0
	fi;
stop_process:
}
proctype sync_monitor(Chandef ch) {
end: if
    :: ch.sending!false;
      run sync_monitor(ch)
    :: ch.closing?true ->
      run closedChan(ch)
    :: ch.is_closed!false ->
      run sync_monitor(ch)
    fi
stop_process:
}

proctype emptyChan(Chandef ch) {
end: if
	 :: ch.async_send?0 -> // a message has been received
    ch.num_msgs = ch.num_msgs + 1
    if
    :: ch.num_msgs == ch.size ->
      run fullChan(ch)
    :: else ->
      run neitherChan(ch)
    fi;
  :: ch.closing?true -> // closing the channel
    run closedChan(ch)
  :: ch.is_closed!false ->
    run emptyChan(ch) // sending channel is open 
  :: ch.sending!false ->
    run emptyChan(ch) // sending channel is open 
fi;
}

proctype fullChan(Chandef ch) {
end: if
  :: ch.async_rcv!0 ->
    ch.num_msgs = ch.num_msgs - 1
    if
    :: ch.num_msgs == 0 ->
      run emptyChan(ch)
    :: else ->
      run neitherChan(ch)
    fi;
  :: ch.closing?true -> // closing the channel
      run closedChan(ch)
  :: ch.is_closed!false -> // sending channel is open 
      run fullChan(ch)
  :: ch.sending!false ->
      run fullChan(ch)
fi;
}

proctype neitherChan(Chandef ch) {
end: if
  :: ch.async_send?0->
     ch.num_msgs = ch.num_msgs + 1
     if
     :: ch.num_msgs == ch.size ->
        run fullChan(ch)
     :: else ->
        run neitherChan(ch)
    fi;
  :: ch.async_rcv!0
     ch.num_msgs = ch.num_msgs - 1
     if
     :: ch.num_msgs == 0 ->
      run emptyChan(ch)
     :: else ->
      run neitherChan(ch)
     fi;
  :: ch.closing?true -> // closing the channel
      run closedChan(ch)
  :: ch.is_closed!false ->  // sending channel is open
     run neitherChan(ch)
  :: ch.sending!false ->  // sending channel is open
     run neitherChan(ch)
fi;
}

proctype closedChan(Chandef ch) {
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true -> // sending state of channel (closed)
    run closedChan(ch)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0 -> // can always receive on a closed chan
    run closedChan(ch)
  fi;
}

