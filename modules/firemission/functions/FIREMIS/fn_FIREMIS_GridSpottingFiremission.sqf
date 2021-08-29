#include "script_component.hpp"

_handle = _this spawn
{
  private _unit = _this select 0;
  private _target = _this select 1;
  private	_roundType = _this select 2;
  private	_fireRate = _unit call FUNC(FIREMIS_ArtGetFireRate);
  [_unit , true] call FUNC(FIREMIS_Dia_SetArtyReadyStatus);

  private	_rounds = ((_unit call FUNC(FIREMIS_Dia_GetArtyAmmo)) select _roundType);
  _unit setVariable [VAR_SART_ARTFMTEXT,_this call FUNC(FIREMIS_GetGridSpottingFiremissionText),true];

  sleep((_unit call FUNC(FIREMIS_Dia_GetArtyAimTime)));
  private _randomPos = [[[_target, _unit getVariable [VAR_SART_ARTSPOTACCURACY,MEANSPOTTINGACCURACY]]],[]] call BIS_fnc_randomPos;
  private _eta = [_unit,_randomPos, ((_unit call FUNC(FIREMIS_Dia_GetArtyAmmo)) select _roundType) select 0] call FUNC(FIREMIS_Dia_GetArtyEta);
  _unit commandArtilleryFire [_randomPos,  ((_unit call FUNC(FIREMIS_Dia_GetArtyAmmo)) select _roundType) select 0, 1];
  private _waitTime = (_fireRate * (_unit getVariable [VAR_SART_ARTFIRERATE,MEANFIRERATE]));
  sleep(_waitTime);
  [_unit,objNULL] call FUNC(FIREMIS_Dia_SetArtyCaller);
  [_unit, false] call FUNC(FIREMIS_Dia_SetArtyReadyStatus);
};
