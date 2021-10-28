#include "..\script_component.hpp"

if (CBA_missionTime >= GVAR(shiverCheckTime)) then {
	if (goggles player isEqualTo "" || {hmd player isEqualTo ""} || {uniform player isEqualTo ""} || {headgear player isEqualTo ""}) then {
		if (GVAR(shiverTimer) > GVAR(shiverInterval)) then {
			enableCamShake true;

			_sound = selectRandom ["shiver_1","shiver_2","shiver_3","shiver_4"];

			[{
				playSound _this;

				addCamShake [0.1,(5 + (random 10)) * 2,25];
			}, _sound, 1] call CBA_fnc_waitAndExecute;

			GVAR(shiverInterval) = 20 + (random 30);
			GVAR(shiverTimer) = 0;
		} else {
			GVAR(shiverTimer) = GVAR(shiverTimer) + 5;
		};
	} else {
		if (GVAR(shiverTimer) != 0) then {
			GVAR(shiverTimer) = 0;
		};
	};

	GVAR(shiverCheckTime) = CBA_missionTime + 5;
};
