#ifdef description_XEH_PreInit
	class DAYL {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\daylight\preInitClient.sqf'";
		serverInit = "'' call compile preprocessFileLineNumbers 'modules\daylight\preInitServer.sqf'";
	};
#endif

#ifdef description_params
	#include "params.hpp"
#endif
