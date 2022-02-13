#include "script_component.hpp"

[{GETMVAR(bluforIsReady, false) && {GETMVAR(opforIsReady, false)}}, {
	[{[-2, {
		hint "Both sides are ready, the mission will begin in:\n 15 seconds";
		[{[-2, {
			hint "Mission begins in:\n 10 seconds";
			[{[-2, {
				hint "Mission begins in:\n 5 seconds";
				[{[-2, {
					SETMPVAR(missionStarter, True);
					["Mission is LIVE"] remoteExec ["hint"];
				}] call CBA_fnc_globalExecute;}, [], 5] call CBA_fnc_waitAndExecute;
			}] call CBA_fnc_globalExecute;}, [], 5] call CBA_fnc_waitAndExecute;
		}] call CBA_fnc_globalExecute;}, [], 5] call CBA_fnc_waitAndExecute;
	}] call CBA_fnc_globalExecute;}, [], 5] call CBA_fnc_waitAndExecute;
}, []] call CBA_fnc_waitUntilAndExecute;
