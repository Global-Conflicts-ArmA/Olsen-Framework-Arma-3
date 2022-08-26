#include "script_component.hpp"


params ["_pos",["_radius",500,[0]],["_bldAmt",25,[0]]];
private _blds = [];
private _rblds = [_pos,_radius] call FUNC(getBuildings);
for "_i" from 0 to _bldAmt step 1 do {
    private _index = (floor random (count _rblds));
    private _bld = _rblds select _index;
    _blds pushBack _bld;
    _rblds deleteAt _index;
} foreach _rblds;
_blds
