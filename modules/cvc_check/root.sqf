#ifdef description_XEH_PreInit
	class CVCCHECK {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\cvc_check\preInitClient.sqf'";
	};
#endif

#ifdef framework

	#include "init.sqf"

#endif

#ifdef description_functions

	#include "functions\CfgFunctions.hpp"

#endif
