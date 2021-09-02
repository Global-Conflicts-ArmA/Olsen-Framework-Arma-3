#include "script_component.hpp"

params[
  ["_unit", objNull, [objNull]],
  ["_target", objNull, [objNull, []]],
  ["_dispersion", 100, [100]],
  ["_burstSize", 0, [0]],
  ["_roundClassName", "", [""]]
];

_unit call FUNC(FIREMIS_InternalRepackArtilleryMagazines);
private _hasAmmunition = false;

diag_log format ["_unit: %1, _target: %2", _unit, _target];

{
  if(_x select 0 == _roundClassName) then
  {
      _hasAmmunition = true;
      _burstSize = _burstSize min (_x select 1);
  };
}forEach (_unit call FUNC(FIREMIS_Dia_GetArtyAmmo));
if(_hasAmmunition) then
{
  _randomPos = [[[_target, _dispersion]],[]] call BIS_fnc_randomPos;
  _randomPos =	[[[_randomPos, _unit getVariable[VAR_SART_ARTACCURACY,MEANPlOTTEDACCURACY]]],[]] call BIS_fnc_randomPos;
  _unit commandArtilleryFire [_randomPos,  _roundClassName, _burstSize];
};
