#include "script_component.hpp"

//Example, to be run only once, SERVER ONLY: ["GAS_CREATEHOTZONE",[position player,100,300]] call CBA_fnc_serverEvent;

params [
	"_target",
	"_shotArea",
	["_timeOut", -1, [-1]]
];

private _gasLogic = "Land_HelipadEmpty_F" createVehicle _target;
_gasLogic setPosATL _target;

_gasLogic setVariable [QGVAR(SHOTAREA), _shotArea, true];
_gasLogic setVariable [QGVAR(TIMEOUT), _timeOut, true];

GVAR(GASLOGICS) pushBack _gasLogic;

[QGVAR(GASZONES), _gasLogic] spawn CBA_fnc_globalEvent;
