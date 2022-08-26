#include "script_component.hpp"

params[
  ["_unit", objNull, [objNull]],
  ["_target", [0,0], [[0,0]]],
  ["_roundType", 0, [0]]
];

private	_rounds = ((_unit call FUNC(Dia_GetArtyAmmo)) select _roundType);
private _text =  (str (_rounds select 1)) + "x " + getText (configfile / "CfgMagazines" / (_rounds select 0) / "displayName");
private	_unitName = _unit call FUNC(Dia_GetArtyDisplayName);
private _ret = "Name: " + _unitName +"\n" +
                      "Firemission type: Spotting-Firemission \n" +
                      "Shell: " + _text +" \n" +
                      "Grid: " + (mapGridPosition _target) +" \n";
_ret
