#include "script_component.hpp"

#include "..\..\settings.sqf"

[{CBA_missionTime > GVAR(JIPDENYTIME)},
{
	missionNamespace setVariable [QGVAR(JIPDenied), true, true];
}, []] call CBA_fnc_waitUntilAndExecute;
