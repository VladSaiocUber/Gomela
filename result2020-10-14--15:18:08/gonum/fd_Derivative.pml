#define Derivative_formula_Stencil  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example422881738/diff/fd/derivative.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int formula_Stencil = Derivative_formula_Stencil;
	Wgdef wg;
	int i;
	
	if
	:: true -> 
				for(i : 1.. formula_Stencil) {
for10:
		};
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
		for(i : 1.. formula_Stencil) {
for20:		wg.Add!1;
		run Anonymous0()
	};
	wg.Wait?0;
	goto stop_process
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	bool state;
stop_process:
}
proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: wg.Add?i -> 
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 -> 
end:		
		if
		:: wg.Add?i -> 
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
		fi
	od;
stop_process:
}
