#include "script_component.hpp"

#include "..\..\Dia\Dia_Global.sqf"

private _unit = _this select 0;
private	_target = _this select 1;
private	_dispersion = _this select 2;
private	_burstCount = _this select 3;
private	_burstSize = _this select 4;
private	_burstWait = _this select 5;
private	_minSpottedDistance = _this select 6;
private	_roundType = _this select 7;
private	_rounds = ((_unit call FNC_GetArtyAmmo) select _roundType);

private _text =  getText (configfile / "CfgMagazines" / (_rounds select 0) / "displayName");

private	_unitName = _unit call FNC_GetArtyDisplayName;


private _ret = 	"Name: " + _unitName + "\n" +
    "Firemission type: Point-Firemission \n" +
    "Shell: " + _text +" \n" +
    "Grid: " + (mapGridPosition _target) + "\n" +
    "Dispersion: " + (str _dispersion) +"\n" +
    "Number of Bursts: " + (str _burstCount) +"\n" +
    "Rounds per Burst: " + (str _burstSize) +"\n" +
    "Delay per Burst: " + (str _burstWait) +"\n" +
    "Minimum Spotted distance: " + (str _minSpottedDistance) +"\n";

_ret
