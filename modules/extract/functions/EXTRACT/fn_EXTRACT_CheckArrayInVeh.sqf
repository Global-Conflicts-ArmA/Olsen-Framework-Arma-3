#include "script_component.hpp"

private _veh = _this select 0;
private _units = _this select 1;

private _total = {_x call FUNC(isAlive)} count _units;
private _inHeli = {_x in _veh} count _units;

if (_inHeli >= _total) then {
  true;
} else {
  false;
};
