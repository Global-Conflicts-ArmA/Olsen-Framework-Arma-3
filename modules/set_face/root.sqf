#include "script_component.hpp"

#ifdef description
    class GVAR(Settings) {
        #include "settings.hpp"
    };
#endif

#ifdef description_XEH_PreInit
	class COMPONENT {
        clientInit = "'' call compile preprocessFileLineNumbers 'modules\set_face\preInitClient.sqf'";
		init = "'' call compile preprocessFileLineNumbers 'modules\set_face\preInitGlobal.sqf'";
	};
#endif

#ifdef description_XEH_Init_CAManBase
	class COMPONENT {
        onRespawn = true;
		init = "_this call compile preprocessFileLineNumbers 'modules\set_face\initPost.sqf'";
	};
#endif

#undef COMPONENT
