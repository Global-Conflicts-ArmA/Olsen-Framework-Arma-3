#include "script_component.hpp"

#ifdef description_XEH_PreInit
	class COMPONENT {
		init = "'' call compile preprocessFileLineNumbers 'modules\gas\preInit.sqf'";
	};
#endif

#ifdef description_XEH_PostInit
	class COMPONENT {
		init = "'' call compile preprocessFileLineNumbers 'modules\gas\init.sqf'";
	};
#endif

#ifdef description_sounds
	#include "sounds.hpp"
#endif

#ifdef description_external_functions
	#include "functions\CfgFunctions.hpp"
#endif

#undef COMPONENT
