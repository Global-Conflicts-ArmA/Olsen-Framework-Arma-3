#include "script_component.hpp"

/* diag_log format ["INFO: Grid spotting firemission! _this =  %1", _this]; */
private _unit = _this select 0;
private _target = _this select 1;
private	_roundType = _this select 2;
[_unit , true] call FUNC(Dia_SetArtyReadyStatus);

_unit setVariable [VAR_SART_ARTFMTEXT, _this call FUNC(GetGridSpottingFiremissionText), true];

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
    /* diag_log format ["INFO: Wait and execute _this =  %1", _this]; */
    _this params ["_unit"];
    [_unit, objNULL] call FUNC(Dia_SetArtyCaller);
    [_unit, false] call FUNC(Dia_SetArtyReadyStatus);
  }, [_unit], _waitTime] call CBA_fnc_waitAndExecute;
}, [_unit, _target, _roundType], _waitTime] call CBA_fnc_waitAndExecute;
