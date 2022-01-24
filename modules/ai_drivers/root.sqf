#include "script_component.hpp"

#ifdef description_XEH_PreInit
	class AiDrivers {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\ai_drivers\preInitClient.sqf'";
	};
#endif

#ifdef description_XEH_PostInit
	class AiDrivers {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\ai_drivers\postInitClient.sqf'";
	};
#endif

#ifdef description_external_functions
	#include "functions\CfgFunctions.hpp"
#endif

#ifdef description
    class GVAR(settings) {
        #include "settings.hpp"
    };
#endif

#undef COMPONENT
