#include "script_component.hpp"

params ["_unit", ["_waitTime", 3, [3]]];

private _mags = magazines _unit;
private _currentMag = currentMagazine _unit;
_mags pushBack _currentMag;
private _compatibleMags = [primaryWeapon _unit] call CBA_fnc_compatibleMagazines;
private _removedMags = _mags select {
    _x in _compatibleMags;
};
TRACE_2("removed magazines",_unit,_removedMags);
_removedMags apply {
    _unit removeMagazine _x
};

[{
  params ["_unit", "_removedMags", "_currentMag"];
  if (_removedMags isEqualTo []) exitWith {};
  _removedMags apply {
      _unit addMagazine _x;
  };
  _unit selectWeapon primaryWeapon _unit;
  _unit reload [currentMuzzle _unit, _currentMag];
}, [_unit, _removedMags, _currentMag], _waitTime] call CBA_fnc_waitAndExecute;
