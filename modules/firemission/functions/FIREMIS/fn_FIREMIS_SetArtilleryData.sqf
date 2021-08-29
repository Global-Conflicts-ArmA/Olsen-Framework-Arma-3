#include "script_component.hpp"

//TODO do some value checking
private _unit = _this select 0;
private _fireRate = if((_this select 1) < 0) then {MEANFIRERATE} else {  _this select 1};;
private	_accuracy = if((_this select 2) < 0) then { MEANPlOTTEDACCURACY} else { _this select 2 };;
private _spottingAccuracy = if((_this select 3) < 0) then {MEANSPOTTINGACCURACY} else { _this select 3  };;
private _aimSpeed = if((_this select 4) < 0) then {MEANAIMTIME} else {   _this select 4};;
private _calcSpeed = if((_this select 5) < 0) then {MEANCALCULATIONTIME } else { _this select 5 };;
private _customName = _this select 6;
private _unlimitedAmmo = _this select 7;
_unit setVariable [VAR_SART_ARTFIRERATE,_fireRate];
_unit setVariable [VAR_SART_ARTACCURACY,_accuracy];
_unit setVariable [VAR_SART_ARTSPOTACCURACY,_spottingAccuracy];
_unit setVariable [VAR_SART_ARTAIMSPEED,_aimSpeed];
_unit setVariable [VAR_SART_ARTCALCSPEED,_calcSpeed];
_unit setVariable [VAR_SART_ARTCUSTOMNAME,_customName,true];
_unit setVariable [VAR_SART_ARTAMMO,_unlimitedAmmo];
if(_unlimitedAmmo) then {_unit call FUNC(FIREMIS_AddEventHandler);};
