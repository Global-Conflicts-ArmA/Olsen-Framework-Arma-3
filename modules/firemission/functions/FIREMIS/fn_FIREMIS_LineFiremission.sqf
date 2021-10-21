#include "script_component.hpp"

private _handle = _this spawn
{
  private _unit = _this select 0;

  private _startPoint = _this select 1;
  private _endPoint = _this select 2;
  private	_burstCount = _this select 3;
  private	_burstSize = _this select 4;
  private	_burstWait = _this select 5;
  /* private	_minSpottedDistance = _this select 6; */
  private	_roundType = _this select 7;
  private	_fireRate = _unit call FUNC(FIREMIS_ArtGetFireRate);
  private _roundClassName = ((_unit call FUNC(FIREMIS_Dia_GetArtyAmmo)) select _roundType) select 0 ;

  [_unit, 0,_burstCount * _burstSize] call FUNC(FIREMIS_Dia_SetArtyFiremissionRoundsRequired);
  [_unit , true] call FUNC(FIREMIS_Dia_SetArtyReadyStatus);
  _unit setVariable [VAR_SART_ARTFMTEXT,_this call FUNC(FIREMIS_GetLineFiremissionText),true];
  [_unit,_startPoint,_roundClassName ] call FUNC(FIREMIS_InternalSpottingFiremission);
  //spotting rounds finished
  sleep( _unit call FUNC(FIREMIS_Dia_GetArtyCalcTime));
    private	_dir = _endPoint vectorDiff  _startPoint;
  _dir = _dir vectorMultiply (1 /_burstCount);
  for "_i" from 0 to _burstCount do
  {

    [_unit,_startPoint vectorAdd (_dir vectorMultiply _i),0,_burstSize,_roundClassName] call FUNC(FIREMIS_InternalFiremission);
    [_unit, ((_unit getVariable [VAR_SART_ARTROUNDSFIRED,[0,0]]) select 0) + _burstSize,_burstCount * _burstSize] call FUNC(FIREMIS_Dia_SetArtyFiremissionRoundsRequired);
    sleep(((_fireRate * (_unit getVariable [VAR_SART_ARTFIRERATE,MEANFIRERATE]) ) * _burstSize) max _burstWait);
  };
  [_unit, false] call FUNC(FIREMIS_Dia_SetArtyReadyStatus);
  [_unit,objNULL] call FUNC(FIREMIS_Dia_SetArtyCaller);
  [_unit, 0,0] call FUNC(FIREMIS_Dia_SetArtyFiremissionRoundsRequired);
};
(_this select 0) setVariable [VAR_SART_FMHANDLE,_handle,true];
