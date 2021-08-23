#include "script_component.hpp"

#include "..\..\Dia\Dia_Global.sqf"

_handle = _this spawn
{
  private _unit = _this select 0;
  private _target = _this select 1;
  private _mils = _this select 2;
  private _distance = _this select 3;
  private	_roundType = _this select 4;
  private	_loc = [_target,true] call CBA_fnc_mapGridToPos;
  private	_degrees = MILSPERROUND / _mils * 360.0;
  private _dir = [cos _degrees,sin _degrees,0];
  private _target =  _loc vectorAdd (_dir vectorMultiply _distance);

  private	_fireRate = _unit call FUNC(FIREMIS_ArtGetFireRate);
  [_unit , true] call FNC_SetArtyReadyStatus;

  private	_rounds = ((_unit call FNC_GetArtyAmmo) select _roundType);
  _unit setVariable [VAR_SART_ARTFMTEXT,_this call FUNC(FIREMIS_GetPolarSpottingFiremissionText),true];

  sleep((_unit call FNC_GetArtyAimTime));
  _randomPos = [[[_target, _unit getVariable [VAR_SART_ARTSPOTACCURACY,MEANSPOTTINGACCURACY]]],[]] call BIS_fnc_randomPos;
    _eta = [_unit,_randomPos, ((_unit call FNC_GetArtyAmmo) select _roundType) select 0] call FNC_GetArtyEta;
  _unit commandArtilleryFire [_randomPos,  ((_unit call FNC_GetArtyAmmo) select _roundType) select 0, 1];
  _waitTime = (_fireRate * (_unit getVariable [VAR_SART_ARTFIRERATE,MEANFIRERATE]));
  sleep(_waitTime);
  [_unit,objNULL] call FNC_SetArtyCaller;
  [_unit, false] call FNC_SetArtyReadyStatus;
};
