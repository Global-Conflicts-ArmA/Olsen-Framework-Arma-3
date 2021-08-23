#include "script_component.hpp"

#include "..\..\Dia\Dia_Global.sqf"

private _unit = _this select 0;
private	_startGrid = _this select 1;
private	_endGrid = _this select 2;
private	_burstCount = _this select 3;
private	_burstSize = _this select 4;
private	_burstWait = _this select 5;
private	_minSpottedDistance = _this select 6;
private	_roundType = _this select 7;
private	_rounds = ((_unit call FNC_GetArtyAmmo) select _roundType) select 0;
private _text =  getText (configfile / "CfgMagazines" / _rounds / "displayName");

_unitName = _unit call FNC_GetArtyDisplayName;


_ret = 	"Name: " + _unitName +"\n" +
    "Firemission type: Line-Firemission \n" +
    "Shell: " + _text +" \n" +
    "Startgrid: " + (mapGridPosition _startGrid) + "\n" +
    "Endgrid: " + (mapGridPosition _endGrid) +"\n" +
    "Number of Bursts: " + (str _burstCount) +"\n" +
    "Rounds per Burst: " + (str _burstSize) +"\n" +
    "Delay per Burst: " + (str _burstWait) +"\n" +
    "Minimum Spotted distance: " + (str _minSpottedDistance) +"\n";

_ret
