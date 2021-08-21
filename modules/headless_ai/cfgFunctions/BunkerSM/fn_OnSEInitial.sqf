#include "..\..\script_macros.hpp"

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

private _targetClass = "CBA_O_InvisibleTarget";
private _side = side _unit;
if ([_side, east] call BIS_fnc_sideIsEnemy) then {
    _targetClass = "CBA_O_InvisibleTarget";
} else {
    if ([_side, west] call BIS_fnc_sideIsEnemy) then {
        _targetClass = "CBA_B_InvisibleTarget";
    } else {
        if ([_side, independent] call BIS_fnc_sideIsEnemy) then {
            _targetClass = "CBA_I_InvisibleTarget";
        };
    };
};
private _invisibleTarget = _targetClass createVehicleLocal [0,0,0];
_invisibleTarget allowdamage false;
private _invisibleTargetHelper = "Sign_Sphere100cm_F" createVehicleLocal [0,0,0];
if (GETMVAR(UseMarkers,false)) then {
    _invisibleTargetHelper setobjecttexture [0,"#(rgb,8,8,3)color(1,0,0,1)"];
} else {
    _invisibleTargetHelper setobjecttexture [0,""];
};
_invisibleTargetHelper attachTo [_invisibleTarget, [0,0,0]];
SETVAR(_unit,InvisibleTarget,_invisibleTarget);

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
	SETVAR(_group,Mission,"BUNKER");
	SETVAR(_group,CurrentTarget,objnull);
	SETVAR(_group,InitialWPSet,true);
};

//private _otherfriendlies = (units (group _unit));
//private _Distance = _Unit getvariable ["PZAI_BunkerDistance",(PZAI_BunkerDistance)];
//private _ReleaseDist = _Unit getvariable ["PZAI_BunkerReleaseDist",(PZAI_BunkerReleaseDist)];
//private _Release = _Unit getvariable ["PZAI_BunkerRelease",(PZAI_BunkerRelease)];

