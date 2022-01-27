#include "script_macros.hpp"

#ifdef description
	#include "CfgRemoteExec.hpp"
#endif

#ifdef description_other
    #include "StateMachines.hpp"
#endif

#ifdef description_external_functions
	#include "CfgFunctions.hpp"
#endif

#ifdef description_XEH_PreInit
	class COMPONENT {
		Init = "call compile preProcessFileLineNumbers 'modules\headless_ai\cfgXEH\init\GlobalPreInit.sqf';";
		serverInit = "call compile preProcessFileLineNumbers 'modules\headless_ai\cfgXEH\init\ServerPreInit.sqf';";
		clientInit = "call compile preProcessFileLineNumbers 'modules\headless_ai\cfgXEH\init\ClientPreInit.sqf';";
	};
#endif

#ifdef description_XEH_FiredMan_CAManBase
	class COMPONENT {
		firedMan = QUOTE(_this call FUNC(onFiredMan));
	};
#endif

#ifdef description_XEH_InitPost_CAManBase
	class COMPONENT {
		init = "call compile preprocessFileLineNumbers 'modules\headless_ai\cfgXEH\init\initPostMan.sqf'";
	};
#endif

#undef COMPONENT
