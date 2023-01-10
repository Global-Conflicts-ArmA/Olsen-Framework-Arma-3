#include "script_component.hpp"

#ifdef description_XEH_PostInit
	class COMPONENT {
		clientInit = "call compile preprocessFileLineNumbers 'modules\clicker\postinitClient.sqf'";
	};
#endif

#ifdef description_XEH_PreInit
	class COMPONENT {
		clientInit = "call compile preprocessFileLineNumbers 'modules\clicker\preinitClient.sqf'";
	};
#endif

#ifdef description_external_functions
	#include "functions\CfgFunctions.hpp"
#endif

#undef COMPONENT
