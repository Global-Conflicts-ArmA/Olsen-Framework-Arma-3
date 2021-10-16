#include "script_component.hpp"

#ifdef description
	#include "endTypes.hpp"
#endif

#ifdef description_debriefing_sections
	class Stats {
		title = "Mission Stats";
		variable = QGVAR(FW_EndStats);
	};
#endif

#ifdef description_XEH_PreInit
	class COMPONENT {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\a3_endscreen\preInitClient.sqf'";
	};
#endif

#ifdef description_external_functions
	#include "functions\CfgFunctions.hpp"
#endif

#undef COMPONENT
