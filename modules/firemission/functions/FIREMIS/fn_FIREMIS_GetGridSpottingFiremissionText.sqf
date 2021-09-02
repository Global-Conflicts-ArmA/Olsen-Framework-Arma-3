#include "script_component.hpp"

params[
  ["_unit", objNull, [objNull]],
  ["_target"],
  ["_roundType"]
];

private	_rounds = ((_unit call FUNC(FIREMIS_Dia_GetArtyAmmo)) select _roundType);
private _text =  (str (_rounds select 1)) + "x " + getText (configfile / "CfgMagazines" / (_rounds select 0) / "displayName");
private	_unitName = _unit call FUNC(FIREMIS_Dia_GetArtyDisplayName);
private _ret = "Name: " + _unitName +"\n" +
                      "Firemission type: Spotting-Firemission \n" +
                      "Shell: " + _text +" \n" +
                      "Grid: " + (mapGridPosition _target) +" \n";
_ret
