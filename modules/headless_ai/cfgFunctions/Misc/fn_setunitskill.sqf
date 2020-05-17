#include "..\..\script_macros.hpp"


params ["_unit"];

if (GETVAR(_unit,ManualSkill,false)) exitwith {};

//Set custom skills set in settings.sqf
if (GVAR(CustomSkillEnabled)) then {
	_unit setSkill ["aimingspeed", GVAR(CustomSkill_aimingspeed)];
	_unit setSkill ["spotdistance", GVAR(CustomSkill_spotdistance)];
	_unit setSkill ["aimingaccuracy", GVAR(CustomSkill_aimingaccuracy)];
	_unit setSkill ["aimingshake", GVAR(CustomSkill_aimingshake)];
	_unit setSkill ["spottime", GVAR(CustomSkill_spottime)];
	_unit setSkill ["reloadspeed", GVAR(CustomSkill_reloadspeed)];
	_unit setSkill ["endurance", GVAR(CustomSkill_endurance)];
	_unit setSkill ["commanding", GVAR(CustomSkill_commanding)];
	_unit setSkill ["general", GVAR(CustomSkill_general)];
	_unit setSkill ["courage", GVAR(CustomSkill_courage)];
};
