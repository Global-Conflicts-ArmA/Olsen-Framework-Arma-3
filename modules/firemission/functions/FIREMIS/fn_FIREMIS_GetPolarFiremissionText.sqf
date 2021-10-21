#include "script_component.hpp"

params[
  ["_unit", objNull, [objNull]],
  ["_callGrid", [0,0], [[0,0]]],
  ["_mils", 0, [0]],
  ["_distance", 0, [0]],
  ["_dispersion", 0, [0]],
  ["_burstCount", 0, [0]],
  ["_burstSize", 0, [0]],
  ["_burstWait", 0, [0]],
  ["_minSpottedDistance", 100, [100]],
  ["_roundType", 0, [0]]
];

/* private	_loc = [_callGrid,true] call CBA_fnc_mapGridToPos; */
/* private	_degrees = MILSPERROUND / _mils * 360; */
/* private _dir = [cos _degrees,sin _degrees,0]; */

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
