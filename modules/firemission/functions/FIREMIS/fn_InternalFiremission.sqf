#include "script_component.hpp"

params[
  ["_unit", objNull, [objNull]],
  ["_target", objNull, [objNull, []]],
  ["_dispersion", 100, [100]],
  ["_burstSize", 0, [0]],
  ["_roundClassName", "", [""]]
];

_unit call FUNC(InternalRepackArtilleryMagazines);
private _hasAmmunition = false;

diag_log format ["INFO: Firemission - _unit: %1, _target: %2", _unit, _target];

(_unit call FUNC(Dia_GetArtyAmmo)) apply {
  if(_x select 0 == _roundClassName) then {
      _hasAmmunition = true;
      _burstSize = _burstSize min (_x select 1);
  };
};

/* diag_log format ["INFO: Has ammunition? = %1", _hasAmmunition]; */

if(_hasAmmunition) then {
  private _randomPos = [[[_target, _dispersion]],[]] call BIS_fnc_randomPos;
  _randomPos =	[[[_randomPos, _unit getVariable[VAR_SART_ARTACCURACY,MEANPlOTTEDACCURACY]]], []] call BIS_fnc_randomPos;
  /* diag_log format ["INFO: Firing = %1 x %2", _roundClassName, _burstSize]; */
  _unit commandArtilleryFire [_randomPos,  _roundClassName, _burstSize];
};
