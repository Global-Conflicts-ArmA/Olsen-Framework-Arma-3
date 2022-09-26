#include "script_component.hpp"

#ifdef description_XEH_InitPost_CAManBase
	class COMPONENT {
		init = "call compile preprocessFileLineNumbers 'modules\hostage\postInitClient.sqf'";
	};
#endif

#ifdef description_external_functions
	#include "functions\CfgFunctions.hpp"
#endif

#undef COMPONENT
