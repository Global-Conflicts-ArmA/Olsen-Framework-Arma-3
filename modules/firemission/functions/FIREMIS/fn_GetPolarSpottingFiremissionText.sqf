#include "script_component.hpp"

params[
  ["_unit", objNull, [objNull]],
  ["_callGrid", [0,0], [[0,0]]],
  ["_mils", 0, [0]],
  ["_distance", 0, [0]],
  ["_roundType", 0, [0]]
];

private	_loc = [_callGrid,true] call CBA_fnc_mapGridToPos;
private	_degrees = MILSPERROUND / _mils * 360.0;
private _dir = [cos _degrees,sin _degrees,0];
private _target =  _loc vectorAdd (_dir vectorMultiply _distance);
private	_rounds = ((_unit call FUNC(Dia_GetArtyAmmo)) select _roundType);
private _text =   getText (configfile / "CfgMagazines" / (_rounds select 0) / "displayName");
private	_unitName = _unit call FUNC(Dia_GetArtyDisplayName);
private _ret = 	"Name: " + _unitName +"\n" +
                      "Firemission type: Spotting-Firemission \n" +
                      "Shell: " + _text +" \n" +
                      "Mils: " + (str _mils) +" \n" +
                      "Distance: " + (str _distance) +" \n" +
                      "Grid: " + (mapGridPosition _target) +" \n";
_ret
