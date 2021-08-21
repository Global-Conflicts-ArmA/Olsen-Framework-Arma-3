#ifdef description_functions

	/* #include "functions.hpp" */

#endif

#ifdef description_sounds

	#include "sounds.hpp"

#endif

#ifdef framework

	#include "init.sqf"

#endif

#ifdef description_XEH_PreInit
	class BPKCHST {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\backpack_on_chest\preInitClient.sqf'";
	};
#endif

#ifdef description_functions
	#include "functions\CfgFunctions.hpp"
#endif
