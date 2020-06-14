#include "script_component.hpp"
params ["_lines",["_ignoreObj",objNull]];

private _isOnGround = true;
for "_i" from 0 to 3 step 1 do {
    _x = _lines select _i;
    private _intersectingObjects = lineIntersectsSurfaces [AGLToASL (_x select 0), AGLToASL (_x select 1), _ignoreObj];
    if ((_intersectingObjects isEqualTo []) && {!(terrainIntersect [_x select 0, _x select 1])}) exitWith {_isOnGround = false};
};

_isOnGround
