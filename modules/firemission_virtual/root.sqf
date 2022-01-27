#include "script_component.hpp"

#ifdef description_XEH_PreInit
	class COMPONENT {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\firemission_virtual\preInitClient.sqf'";
		serverInit = "'' call compile preprocessFileLineNumbers 'modules\firemission_virtual\preInitServer.sqf'";
	};
#endif

#ifdef description_XEH_PostInit
	class COMPONENT {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\firemission_virtual\postInitClient.sqf'";
		init = "'' call compile preprocessFileLineNumbers 'modules\firemission_virtual\postInit.sqf'";
		serverInit = "'' call compile preprocessFileLineNumbers 'modules\firemission_virtual\postInitServer.sqf'";
	};
#endif

#ifdef description
	#include "dia\dia_polarFiremission.hpp"
#endif

#ifdef description_external_functions
	#include "functions\CfgFunctions.hpp"
#endif

#undef COMPONENT
