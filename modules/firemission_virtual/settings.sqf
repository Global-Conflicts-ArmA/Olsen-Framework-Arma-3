#include "script_component.hpp"

["tin_var_artyObservers", [	//[OBJECT,"STRING",side]

]] call FUNC(publicVariable);

// Example
/* ["tin_var_artyObservers", [	//[OBJECT,"STRING",side]
	[test_unit, "Test Unit", blufor]
]] call FUNC(publicVariable); */

["tin_var_artyFreq_west", 1] call FUNC(publicVariable);
["tin_var_artyFreq_east", 0] call FUNC(publicVariable);
["tin_var_artyFreq_independent", 0] call FUNC(publicVariable);
["tin_var_artyFreq_civilian", 0] call FUNC(publicVariable);

["tin_var_artyBatteries", [	//[[name,ready,[ammoClass,quantity],guns,dispersion,reloadTime,calcTime,flightTime,delayTime,side] - delayTime and calcTime can be an array [min,max]
	["ORCO", true, [
		["rhs_12Rnd_m821_HE", 80],
		["8Rnd_82mm_Mo_Smoke_white", 20]
	], 4, 180, 5, 60, 35, [0.1, 1.0], west]
]] call FUNC(publicVariable);

["tin_var_fireMissions_west", [

]] call FUNC(publicVariable);

["tin_var_fireMissions_east", [

]] call FUNC(publicVariable);

["tin_var_fireMissions_independent", [

]] call FUNC(publicVariable);

["tin_var_fireMissions_civilian", [

]] call FUNC(publicVariable);
