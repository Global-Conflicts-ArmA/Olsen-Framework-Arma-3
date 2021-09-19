#ifdef description_XEH_PreInit
	class KOBLD_DAYL {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\kobld_daylight\preInitClient.sqf'";
		serverInit = "'' call compile preprocessFileLineNumbers 'modules\kobld_daylight\preInitServer.sqf'";
	};
#endif

#ifdef description_params
	#include "params.hpp"
#endif
