package promela

const (
	// Anomalous errors
	UNPARSABLE_FUNCTION_NAME                    = "Could not parse the name of the function at pos: "
	UNPARSABLE_ARG                              = "Could not parse an arguments at pos: "
	METHOD_USED_WITH_DIFFERENT_NUMBER_OF_PARAMS = "A method is used with a different number of parameters"
	MUTEX_OP_ON_NON_SEL                         = "A lock or unlock on a sync.mutex was done on a mutex which is not a selector expr at pos: "

	// Imprecise control flow
	FUNC_DECLARED_AS_VAR = "Function declared as a variable at pos: "
	UNKNOWN_DECL         = "Cannot find decl of concurrent function at pos: "
	DEFER_IN_FOR         = "Defer stmt in for at pos: "
	DEFER_IN_IF          = "Defer stmt in if at pos: "
	DEFER_IN_RANGE       = "Defer stmt in range at pos: "
	DEFER_IN_SELECT      = "Defer stmt in select statement at pos: "
	DEFER_IN_SWITCH      = "Defer stmt in switch statement at pos: "
	UNKNOWN_GO_FUNC      = "Concurrent function declaration of go statement not found at pos: "
	RECURSIVE_FUNCTION   = "There is a recursive function found at pos : "

	// Imprecise aliasing
	// 0. Bare-bones aliasing
	CHAN_ALIASING  = "Chan aliasing found at pos :"
	MUTEX_ALIASING = "Mutex aliasing found at pos :"
	WG_ALIASING    = "Waitgroup aliasing found at pos :"
	// 1. Loop allocations
	WAITGROUP_IN_FOR = "Waitgroup created in a for loop at pos: "
	MUTEX_IN_FOR     = "Mutex created in a for loop at pos: "
	CHAN_IN_FOR      = "Channel created in a for loop at pos: "
	// 2. Aggregate data structures
	CHAN_DECLARED_IN_STRUCT = "Found a chan declared in a struct at pos: "
	WG_DECLARED_IN_STRUCT   = "Found a waitgroup declared in a struct at pos: "
	CHAN_IN_MAP             = "Map of chan at pos: "
	CHAN_IN_LIST            = "List of chan at pos: "
	WG_IN_MAP               = "Map of wg at pos: "
	WG_IN_LIST              = "List of wg at pos: "
	MUTEX_IN_MAP            = "Map of mutex at pos: "
	MUTEX_IN_LIST           = "List of mutex at pos: "
	// 3. Unknown bindings
	UNKNOWN_ARG        = "Found a function call that contains an unknown chan or wg at pos: "
	UNKNOWN_NOTIFY     = "Can not find send of signal.Notify at pos: "
	UNKNOWN_RCV        = "A receive was found on a channel that could not be parsed at pos: "
	UNKNOWN_SEND       = "A send on a channel was found that could not be parsed at pos: "
	UNKNOWN_RANGE      = "A range on a channel was found but could not parse channel at pos: "
	UNKNOWN_CHAN_CLOSE = "A close on an unknown channel was found at pos: "
	UNKNOWN_MUTEX      = "A lock or unlock on a sync.Mutex was done on a unknown mutex at pos: "
	UNKNOWN_MUTEX_OP   = "An operation that could not be determined on a sync.Mutex at pos: "
	// 4. Escaping channels
	RETURN_CHAN   = "Returning a channel at pos: "
	RETURN_WG     = "Returning a waitgroup at pos: "
	RETURN_MUTEX  = "Returning a Mutex at pos: "
	RETURN_STRUCT = "Returning a struct which contains a chan, wg, and/or mutex at pos: "

	// Not covered features
	SELECT_WITH_NO_BRANCH = "Found a select with no branches at pos: "
	ELLIPSIS              = "A call expression with ellipsis as args was found at pos : "
)
