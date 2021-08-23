#include "script_component.hpp"

#include "..\..\Dia\Dia_Global.sqf"

private _unit = _this select 0;
private _callGrid = _this select 1;

private _mils = _this select 2;
private _distance = _this select 3;

private	_dispersion = _this select 4;
private	_burstCount = _this select 5;
private	_burstSize = _this select 6;
private	_burstWait = _this select 7;
private	_minSpottedDistance = _this select 8;
private	_roundType = _this select 9;

private	_loc = [_callGrid,true] call CBA_fnc_mapGridToPos;
private	_degrees = MILSPERROUND / _mils * 360.0;
private _dir = [cos _degrees,sin _degrees,0];

[_unit,_loc vectorAdd (_dir vectorMultiply _distance),_dispersion,_burstCount,_burstSize,_burstWait,_minSpottedDistance,_roundType] call FUNC(FIREMIS_PointFiremission);
