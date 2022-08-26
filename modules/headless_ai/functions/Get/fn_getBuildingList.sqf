#include "script_component.hpp"


params ["_pos","_radius","_occupy","_grpcount",["_bld",[],[[]]],["_bldPos",[],[[]]]];
switch (_occupy) do {
    case 2: {
        _bld pushBack ([_pos,_radius] call FUNC(getNearestBuilding));
        _bldPos = (_bld select 0) buildingPos -1;
    };
    case 3: {
        _bld pushBack ([_pos,_radius] call FUNC(getRandomBuilding));
        _bldPos = (_bld select 0) buildingPos -1;
    };
    case 4: {
        _bld = [_pos,_radius] call FUNC(getNearestGroupBuildings);
    };
    case 5: {
        _bld = [_pos,_radius] call FUNC(getRandomGroupBuildings);
    };
    case 6: {
        _bld = [_pos,_radius,_grpcount] call FUNC(getNearestBuildings);
    };
    case 7: {
        _bld = [_pos,_radius,_grpcount] call FUNC(getRandomBuildings);
    };
    default {
        _bld pushBack (nearestBuilding _pos);
        _bldPos = (_bld select 0) buildingPos -1;
    };
};
[_bld,_bldPos]
