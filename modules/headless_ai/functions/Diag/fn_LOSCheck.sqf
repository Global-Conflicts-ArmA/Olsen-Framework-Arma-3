#include "script_component.hpp"

params [
    ["_unit", objNull, [objNull]],
    ["_target", objNull, [objNull]],
    ["_bunkerMode", false, [false]]
];

if (_target isEqualTo objNull) exitwith {false};

private _ignoreDirection = _unit getVariable [QGVAR(ignoreDirection), (GETMVAR(ignoreDirection,false))];
if (!_ignoreDirection && {!([_unit, _target] call FUNC(isFacing))}) exitWith {
    false
};

private _sightLevel = if (_bunkerMode) then {
    _unit getVariable [QGVAR(BunkerSightlevel), (GETMVAR(BunkerSightlevel,0.15))];
} else {
    _unit getVariable [QGVAR(Sightlevel), (GETMVAR(Sightlevel,0.15))];
};

private _getpos1 = if ((vehicle _unit) != _unit) then {
    getPosWorld (vehicle _unit);
} else {
    eyepos _unit
};
private _getposTarget = if (vehicle _target == _target) then {
    AGLToASL (_target modelToWorld (_target selectionPosition "spine3"))
} else {
    getPosWorld (vehicle _target)
};

private _cansee = [(vehicle _unit), "VIEW", objNull] checkVisibility [_getpos1, _getposTarget];

if (GETMVAR(VerboseDebug,false)) then {
	TRACE_3("",_unit,(_cansee >+ _sightLevel),_target);
};

(_cansee >= _sightLevel)
