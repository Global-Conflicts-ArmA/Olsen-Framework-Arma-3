#include "..\..\script_macros.hpp"


params ["_pos",["_radius",500,[0]],["_bldAmt",25,[0]]];
private _blds = [_pos,_radius] call FUNC(getBuildings);
if (_blds isEqualTo []) then {
    _blds = [_pos,(_radius + 500)] call FUNC(getBuildings);
    if (count _blds > _bldAmt) then {
        _blds resize _bldAmt;
    };
} else {
    if (count _blds > _bldAmt) then {
        _blds resize _bldAmt;
    };
};
_blds
