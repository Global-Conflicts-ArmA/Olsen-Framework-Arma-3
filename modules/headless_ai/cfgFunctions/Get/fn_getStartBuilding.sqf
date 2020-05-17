#include "..\..\script_macros.hpp"


params ["_gpos","_taskRadius","_i",["_pos",[],[[]]]];
private _bp = (([_gpos,_taskRadius] call FUNC(getNearestBuilding)) buildingPos -1);
if ((count _bp) >= 1) then {
    _pos = _bp select (_i % (count _bp));
} else {
    if (_bp isEqualTo []) then {
        LOG_1("Group at %1 was unable to detect any enterable buildings within range.",_gpos);
    };
};
_pos
