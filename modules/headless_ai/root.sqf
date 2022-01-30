#include "script_component.hpp"

#ifdef description
	#include "functions\CfgRemoteExec.hpp"
    class GVAR(Settings) {
        #include "settings.hpp"
        class Bunker {
            #include "settings\bunker.hpp"
        };
        //class Commander {
        //    #include "settings\commander.hpp"
        //};
        class SightAid {
            #include "settings\sight.hpp"
        };
        class CustomSkill {
            #include "settings\skill.hpp"
        };
    };
#endif

#ifdef description_other
    #include "functions\StateMachines.hpp"
#endif

#ifdef description_external_functions
	#include "functions\CfgFunctions.hpp"
#endif

#ifdef description_XEH_PreInit
	class COMPONENT {
		Init = "call compile preProcessFileLineNumbers 'modules\headless_ai\preInitGlobal.sqf';";
		serverInit = "call compile preProcessFileLineNumbers 'modules\headless_ai\preInitServer.sqf';";
		clientInit = "call compile preProcessFileLineNumbers 'modules\headless_ai\preInitClient.sqf';";
	};
#endif

#ifdef description_XEH_FiredMan_CAManBase
	class COMPONENT {
		firedMan = QUOTE(_this call FUNC(onFiredMan));
	};
#endif

#ifdef description_XEH_InitPost_CAManBase
	class COMPONENT {
		init = QUOTE(_this call FUNC(initPostMan));
	};
#endif

#undef COMPONENT
