#include "script_component.hpp"

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
private	_degrees = MILSPERROUND / _mils * 360;
private _dir = [cos _degrees,sin _degrees,0];

private	_rounds = ((_unit call FUNC(FIREMIS_Dia_GetArtyAmmo)) select _roundType);

private _text =  getText (configfile / "CfgMagazines" / (_rounds select 0) / "displayName");

private	_unitName = _unit call FUNC(FIREMIS_Dia_GetArtyDisplayName);


private _ret = 	"Name: " + _unitName + "\n" +
    "Firemission type: Polar to Point-Firemission \n" +
    "Shell: " + _text +" \n" +
    "Call Grid: " + (mapGridPosition _callGrid) + "\n" +
    "Mils: " +(str _mils) + "\n" +
    "Distance: " + (str _distance) + "\n" +
    "Dispersion: " + (str _dispersion) +"\n" +
    "Number of Bursts: " + (str _burstCount) +"\n" +
    "Rounds per Burst: " + (str _burstSize) +"\n" +
    "Delay per Burst: " + (str _burstWait) +"\n" +
    "Minimum Spotted distance: " + (str _minSpottedDistance) +"\n";

_ret
