#ifdef description
		#include "Dia\Dia_PointFiremission.hpp"
		#include "Dia\Dia_LineFiremission.hpp"
		#include "Dia\Dia_BracketFiremission.hpp"
		#include "Dia\Dia_DonutFiremission.hpp"
		#include "Dia\Dia_MarkerFiremission.hpp"
		#include "Dia\Dia_GridSpottingFiremission.hpp"
		#include "Dia\Dia_PolarSpottingFiremission.hpp"
		#include "Dia\Dia_PolarFiremission.hpp"
#endif

#ifdef description_XEH_PreInit
	class FIREMIS {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\firemission\preInitClient.sqf'";
	};
#endif

#ifdef description_XEH_PostInit
	class FIREMIS {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\firemission\postInitClient.sqf'";
		serverInit = "'' call compile preprocessFileLineNumbers 'modules\firemission\postInitServer.sqf'";
	};
#endif


#ifdef description_functions
	#include "functions\CfgFunctions.hpp"
#endif
