#include "script_component.hpp"

#ifdef description_XEH_PreInit
	class COMPONENT {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\unconsciousnessFade\preInitClient.sqf'";
		Init = "call compile preProcessFileLineNumbers 'modules\unconsciousnessFade\preInitGlobal.sqf';";
	};
#endif

#ifdef description_XEH_PostInit
	class COMPONENT {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\unconsciousnessFade\postInitClient.sqf'";
	};
#endif

#ifdef description_external_functions
	#include "functions\CfgFunctions.hpp"
#endif
#undef COMPONENT
