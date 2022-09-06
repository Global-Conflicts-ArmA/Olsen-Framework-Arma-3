#include "script_component.hpp"

#ifdef description_XEH_PreInit
	class COMPONENT {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\armor_balance\preInitClient.sqf'";
		Init = "call compile preProcessFileLineNumbers 'modules\armor_balance\preInitGlobal.sqf';";
	};
#endif

#ifdef description_external_functions
	#include "functions\CfgFunctions.hpp"
#endif
#undef COMPONENT
