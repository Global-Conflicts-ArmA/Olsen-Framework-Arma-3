#include "script_component.hpp"

params[
  ["_unit", objNull, [objNull]],
  ["_target", objNull, [objNull, []]],
  ["_roundClassName", "", [""]]
];

sleep((_unit call FUNC(FIREMIS_Dia_GetArtyAimTime)));
private	_dis = 1000;
private	_tempAcc = (_unit getVariable [VAR_SART_ARTSPOTACCURACY,MEANSPOTTINGACCURACY]) + 1;
private _minSpottedDistance = 100;
private	_fireRate = _unit call FUNC(FIREMIS_ArtGetFireRate);

while{(_dis >_minSpottedDistance && SPOTTINGROUNDSREQUIRED)} do
{
      private _randomPos = [[[_target, _tempAcc]],[]] call BIS_fnc_randomPos;
      _dis = _randomPos distance2D _target;
      private _eta = [_unit,_randomPos, _roundClassName] call FUNC(FIREMIS_Dia_GetArtyEta);
      _unit commandArtilleryFire [_randomPos, _roundClassName, 1];
      private _waitTime = (_fireRate * (_unit getVariable [VAR_SART_ARTFIRERATE,MEANFIRERATE])) max _eta;
      sleep(_waitTime max ((_unit getVariable [VAR_SART_ARTAIMSPEED,MEANAIMTIME]) + 1));
      _tempAcc = [_dis,_tempAcc] call FUNC(FIREMIS_GetNewAccuracy);
};
