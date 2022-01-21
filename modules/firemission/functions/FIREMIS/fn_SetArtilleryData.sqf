#include "script_component.hpp"

params[
  ["_unit", objNull, [objNull]],
  ["_var2", 0, [0]],
  ["_var3", 0, [0]],
  ["_var4", 0, [0]],
  ["_var5", 0, [0]],
  ["_var6", 0, [0]],
  ["_customName", "NoName", ["NoName"]],
  ["_unlimitedAmmo", false, [false]]
];

//TODO do some value checking
private _fireRate = if(_var2 < 0) then {MEANFIRERATE} else { _var2 };;
private	_accuracy = if(_var3 < 0) then { MEANPlOTTEDACCURACY} else { _var3 };;
private _spottingAccuracy = if(_var4 < 0) then {MEANSPOTTINGACCURACY} else { _var4 };;
private _aimSpeed = if(_var5 < 0) then {MEANAIMTIME} else { _var5 };;
private _calcSpeed = if(_var6 < 0) then {MEANCALCULATIONTIME } else { _var6 };;
_unit setVariable [VAR_SART_ARTFIRERATE,_fireRate];
_unit setVariable [VAR_SART_ARTACCURACY,_accuracy];
_unit setVariable [VAR_SART_ARTSPOTACCURACY,_spottingAccuracy];
_unit setVariable [VAR_SART_ARTAIMSPEED,_aimSpeed];
_unit setVariable [VAR_SART_ARTCALCSPEED,_calcSpeed];
_unit setVariable [VAR_SART_ARTCUSTOMNAME,_customName,true];
_unit setVariable [VAR_SART_ARTAMMO,_unlimitedAmmo];
if(_unlimitedAmmo) then {_unit call FUNC(AddEventHandler);};
