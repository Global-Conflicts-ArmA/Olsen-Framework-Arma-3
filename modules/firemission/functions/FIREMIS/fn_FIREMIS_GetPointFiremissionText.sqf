#include "script_component.hpp"

params[
  ["_unit", objNull, [objNull]],
  ["_target", objNull, [objNull, []]],
  ["_dispersion", 100, [100]],
  ["_burstCount", 0, [0]],
  ["_burstSize", 0, [0]],
  ["_burstWait", 0, [0]],
  ["_minSpottedDistance", 100, [100]],
  ["_roundType", 0, [0]]
];

private	_rounds = ((_unit call FUNC(FIREMIS_Dia_GetArtyAmmo)) select _roundType);

private _text =  getText (configfile / "CfgMagazines" / (_rounds select 0) / "displayName");

private	_unitName = _unit call FUNC(FIREMIS_Dia_GetArtyDisplayName);

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
