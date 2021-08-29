#include "script_component.hpp"

private _unit = _this select 0;
private	_target = _this select 1;
private	_innerRadius = _this select 2;
private	_outerRadius = _this select 3;
private	_burstCount = _this select 4;
private	_burstSize = _this select 5;
private	_burstWait = _this select 6;
private	_minSpottedDistance = _this select 7;
private	_roundType = _this select 8;
private	_rounds = ((_unit call FUNC(FIREMIS_Dia_GetArtyAmmo)) select _roundType) select 0;
private _text =  getText (configfile / "CfgMagazines" / _rounds / "displayName");

_unitName = _unit call FUNC(FIREMIS_Dia_GetArtyDisplayName);


_ret = 	"Name: " + _unitName +"\n" +
    "Firemission type: Donut-Firemission \n" +
    "Shell: " + _text +" \n" +
    "Targetgrid: " + (mapGridPosition _target) + "\n" +
    "Inner radius: " + (str _innerRadius) +"\n" +
    "Outer radius: " + (str _outerRadius) +"\n" +
    "Number of Bursts: " + (str _burstCount) +"\n" +
    "Rounds per Burst: " + (str _burstSize) +"\n" +
    "Delay per Burst: " + (str _burstWait) +"\n" +
    "Minimum Spotted distance: " + (str _minSpottedDistance) +"\n";

_ret
