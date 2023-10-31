#include "script_component.hpp"

#ifdef description_XEH_PreInit
	class COMPONENT {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\vehicle_boost\preInitClient.sqf'";
	};
#endif

#ifdef description_XEH_PostInit
	class COMPONENT {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\vehicle_boost\postInitClient.sqf'";
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
