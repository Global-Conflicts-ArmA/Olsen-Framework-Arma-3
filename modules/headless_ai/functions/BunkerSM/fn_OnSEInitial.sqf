#include "script_component.hpp"

LOG("startingOnStateInitial");

params ["_unit"];

LOG_1("%1 added to Bunker State Machine",_unit);

private _group = group _unit;

_unit disableAI "PATH";
_unit disableAI "FSM";
dostop _unit;
_unit forcespeed 0;
_group setBehaviour "AWARE";

private _laserTarget = "Sign_Sphere100cm_F" createVehicleLocal [0,0,0];
if !(GETMVAR(UseMarkers,false)) then {
	_laserTarget setobjecttexture [0,""];
};
SETVAR(_unit,laserTarget,_laserTarget);

private _invisibleTarget = [_unit] call FUNC(targetHelper);

private _vectordirandup = GETVAR(_unit,VecDirUp,[ARR_2((vectordir _unit), (vectorup _unit))]);
private _vectordir = (_vectordirandup select 0);
private _azimuth = (((_vectordir) select 0) atan2 ((_vectordir) select 1) + 360) % 360;
private _relpos = _unit getPos [20, _azimuth];
private _laserPos = [(_relpos) select 0, (_relpos) select 1, (((getposASL _unit)) select 2) + (GVAR(AimTargetHeightAdjust))];
_laserTarget setposASL _laserPos;
[_unit, false, _laserTarget] call FUNC(WatchEnemy);

SETVAR(_unit,oldGroup,_group);
SETVAR(_unit,oldTrenchPos,getposASL _unit);
SETVAR(_unit,oldUnitPos,unitpos _unit);
SETVAR(_unit,laserPos,_laserPos);

if ((leader _group) isEqualTo _unit) then {
	SETVAR(_group,Task,"BUNKER");
	SETVAR(_group,CurrentTarget,objNull);
};
