#include "script_component.hpp"

params [
    ["_veh", objNull, [objNull]],
    ["_units", [], [[]]]
];

private _total = {_x call FUNC(isAlive)} count _units;
private _inHeli = {_x in _veh} count _units;

_inHeli >= _total;
