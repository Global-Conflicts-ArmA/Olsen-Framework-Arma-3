#include "script_component.hpp"

#ifdef description
    class GVAR(settings) {
        #include "settings.hpp"
    };
#endif

#ifdef description_XEH_PreInit
	class COMPONENT {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\setup_timer\preInitClient.sqf'";
	};
#endif

#ifdef description_titles
	#include "RscSetupTimer.hpp"
#endif

#ifdef description_notifications
	#include "CfgNotifications.hpp"
#endif

#ifdef description_external_functions
	#include "functions\CfgFunctions.hpp"
#endif

#undef COMPONENT
