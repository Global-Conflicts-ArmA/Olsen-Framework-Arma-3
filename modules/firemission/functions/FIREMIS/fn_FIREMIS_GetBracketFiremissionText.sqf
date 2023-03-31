#include "script_component.hpp"

params[
  ["_unit", objNull, [objNull]],
  ["_startGrid", [0,0], [[0,0]]],
  ["_endGrid", [0,0], [[0,0]]],
  ["_burstCount", 0, [0]],
  ["_burstSize", 0, [0]],
  ["_burstWait", 0, [0]],
  ["_minSpottedDistance", 100, [100]],
  ["_roundType", 0, [0]]
];

private	_rounds = ((_unit call FUNC(FIREMIS_Dia_GetArtyAmmo)) select _roundType) select 0;
private _text =  getText (configfile / "CfgMagazines" / _rounds / "displayName");

private _unitName = _unit call FUNC(FIREMIS_Dia_GetArtyDisplayName);

private _ret = 	"Name: " + _unitName +"\n" +
    "Firemission type: Bracket-Firemission \n" +
    "Shell: " + _text +" \n" +
    "Startgrid: " + (mapGridPosition _startGrid) + "\n" +
    "Endgrid: " + (mapGridPosition _endGrid) +"\n" +
    "Number of Bursts: " + (str _burstCount) +"\n" +
    "Rounds per Burst: " + (str _burstSize) +"\n" +
    "Delay per Burst: " + (str _burstWait) +"\n" +
    "Minimum Spotted distance: " + (str _minSpottedDistance) +"\n";

_ret
