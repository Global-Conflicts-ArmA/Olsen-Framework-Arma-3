#include "..\..\script_macros.hpp"


//unit 1, unit 2
params ["_unit", ["_target", objnull, [objnull]]];

if (_target isEqualTo objnull) exitwith {false};

private _canseeReturn = false;
private _sightLevel = _unit getVariable [QGVAR(BunkerSightlevel), (GETMVAR(BunkerSightlevel,0.15))];

private _getpos1 = getPosWorld (vehicle _unit);
private _getposTarget = if (vehicle _target == _target) then {
    AGLToASL (_target modelToWorld (_target selectionPosition "spine3"))
} else {
    getPosWorld (vehicle _target)
};
//private _unitdirtotarget = (vehicle _unit) getdir (vehicle _unit);
//private _aheadUnit = (vehicle _unit) getpos [10,_unitdirtotarget];
//private _eyeP1 = [_aheadUnit select 0, _aheadUnit select 1, (_getpos1 select 2) + 0.5];
private _eyeP2 = [_getposTarget select 0, _getposTarget select 1,(_getposTarget select 2) + 4];

private _cansee = if ((vehicle _unit) != _unit) then {
    [(vehicle _unit), "VIEW", objNull] checkVisibility [getPosWorld (vehicle _unit), _eyeP2]
} else {
    [_unit, "VIEW", objNull] checkVisibility [eyepos _unit, _eyeP2]
};

//if (GETMVAR(VerboseDebug,false)) then {
//	LOG_3("_unit: %1 _cansee: %2 _target: %3",_unit,_cansee,_target);
//};

_canseeReturn = (_cansee >= _sightLevel);

_canseeReturn
