#include "..\..\script_macros.hpp"

params ["_unit", ["_target", objnull, [objnull]]];

if (_target isEqualTo objnull) exitwith {false};

private _sightLevel = _unit getVariable [QGVAR(BunkerSightlevel), (GETMVAR(BunkerSightlevel,0.15))];

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
	LOG_3("_unit: %1 _cansee: %2 _target: %3",_unit,_cansee,_target);
};

(_cansee >= _sightLevel)

