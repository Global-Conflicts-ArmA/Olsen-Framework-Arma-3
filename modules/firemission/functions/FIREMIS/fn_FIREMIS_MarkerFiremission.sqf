#include "script_component.hpp"

#include "..\..\Dia\Dia_Global.sqf"

if (isServer) then
{
  _handle = _this spawn
  {
      private _unit = _this select 0;
      private	_targetMarker = _this select 1;
      private	_burstCount = _this select 2;
      private	_burstSize = _this select 3;
      private	_burstWait = _this select 4;
      private	_minSpottedDistance = _this select 5;
      private	_roundType = _this select 6;
      private	_fireRate = _unit call FUNC(FIREMIS_ArtGetFireRate);
      private _roundClassName = ((_unit call FNC_GetArtyAmmo) select _roundType) select 0 ;
      [_unit , true] call FNC_SetArtyReadyStatus;
      _unit setVariable [VAR_SART_ARTFMTEXT,_this call FUNC(FIREMIS_GetPointFiremissionText),true];
      [_unit, 0,_burstCount * _burstSize] call FNC_SetArtyFiremissionRoundsRequired;

        //calculateFiremission
        [_unit,_targetMarker,_roundClassName ] call FUNC(FIREMIS_InternalSpottingFiremission);
        //spotting rounds finished
        sleep( (_unit getVariable [VAR_SART_ARTCALCSPEED,MEANCALCULATIONTIME]) + 1);
        for "_i" from 0 to _burstCount do
        {
            _randomPos = [[_targetMarker],[]] call BIS_fnc_randomPos;
            [_unit,_randomPos,0,_burstSize,_roundClassName] call FUNC(FIREMIS_InternalFiremission);
              [_unit, ((_unit getVariable [VAR_SART_ARTROUNDSFIRED,[0,0]]) select 0) + _burstSize,_burstCount * _burstSize] call FNC_SetArtyFiremissionRoundsRequired;
            sleep(((_fireRate * (_unit getVariable [VAR_SART_ARTFIRERATE,MEANFIRERATE]) ) * _burstSize) max _burstWait);
        };

        [_unit, false] call FNC_SetArtyReadyStatus;
        [_unit,objNULL] call FNC_SetArtyCaller;
        [_unit, 0,0] call FNC_SetArtyFiremissionRoundsRequired;
  };
  (_this select 0) setVariable [VAR_SART_FMHANDLE,_handle,true];
};
