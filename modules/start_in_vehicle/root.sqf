#ifdef description_XEH_PreInit
	class StartInVehicle {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\start_in_vehicle\preinitClient.sqf'";
		serverInit = "'' call compile preprocessFileLineNumbers 'modules\start_in_vehicle\preinitServer.sqf'";
	};
#endif

#ifdef description_functions
	#include "functions\CfgFunctions.hpp"
#endif
