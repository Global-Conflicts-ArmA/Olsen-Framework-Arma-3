#include "script_component.hpp"

/* diag_log format ["INFO: Polar spotting firemission! _this =  %1", _this]; */
private _unit = _this select 0;
private _target = _this select 1;
private _mils = _this select 2;
private _distance = _this select 3;
private	_roundType = _this select 4;
private	_loc = [_target,true] call CBA_fnc_mapGridToPos;
private	_degrees = MILSPERROUND / _mils * 360.0;
private _dir = [cos _degrees,sin _degrees,0];
private _target =  _loc vectorAdd (_dir vectorMultiply _distance);

[_unit , true] call FUNC(Dia_SetArtyReadyStatus);

/* private	_rounds = ((_unit call FUNC(Dia_GetArtyAmmo)) select _roundType); */
_unit setVariable [VAR_SART_ARTFMTEXT, _this call FUNC(GetPolarSpottingFiremissionText), true];

private _waitTime = (_unit call FUNC(Dia_GetArtyAimTime));
[{
  _this params ["_unit", "_target", "_roundType"];

  private _tempAcc = ((_unit getVariable [VAR_SART_ARTSPOTACCURACY,MEANSPOTTINGACCURACY]) + 1);
  private _randomPos = [[[_target, _tempAcc]],[]] call BIS_fnc_randomPos;
  private _roundClassName = ((_unit call FUNC(Dia_GetArtyAmmo)) select _roundType) select 0;
  _unit commandArtilleryFire [_randomPos,  _roundClassName, 1];
  private	_fireRate = _unit call FUNC(ArtGetFireRate);
  private _waitTime = (_fireRate * (_unit getVariable [VAR_SART_ARTFIRERATE,MEANFIRERATE]));

  [{
    _this params ["_unit"];
    [_unit, objNULL] call FUNC(Dia_SetArtyCaller);
    [_unit, false] call FUNC(Dia_SetArtyReadyStatus);
  }, [_unit], _waitTime] call CBA_fnc_waitAndExecute;
}, [_unit, _target, _roundType], _waitTime] call CBA_fnc_waitAndExecute;
