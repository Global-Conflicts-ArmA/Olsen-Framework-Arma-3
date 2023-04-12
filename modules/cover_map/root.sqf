#include "script_component.hpp"

#ifdef description
    class GVAR(settings) {
        #include "settings.hpp"
    };
#endif

#ifdef description_XEH_PreInit
	class COMPONENT {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\cover_map\preinitClient.sqf'";
	};
#endif

#ifdef description_external_functions
	#include "functions\CfgFunctions.hpp"
#endif

#undef COMPONENT
