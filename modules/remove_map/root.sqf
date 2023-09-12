#include "script_component.hpp"

#ifdef description_XEH_PreInit
	class COMPONENT {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\remove_map\preinitClient.sqf'";
	};
#endif

#ifdef description_XEH_InitPost_CAManBase
	class COMPONENT {
        onRespawn = true;
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\remove_map\postinitClient.sqf'";
	};
#endif

#ifdef description_external_functions
	#include "functions\CfgFunctions.hpp"
#endif

#undef COMPONENT
