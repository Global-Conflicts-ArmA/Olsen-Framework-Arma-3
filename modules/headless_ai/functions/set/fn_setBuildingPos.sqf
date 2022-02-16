#include "script_component.hpp"


params ["_occupyOption","_i",["_bld",[],[[]]],["_bldPos",[],[[]]],["_pos",[],[[]]],["_return",[],[[]]]];
private ["_uBld"];
switch (_occupyOption) do {
    case 2;
    case 3: {
        _pos = _bldPos select (_i % (count _bldPos));
        _uBld = _bld select 0;
    };
    case 4;
    case 5;
    case 6;
    case 7: {
        _uBld = _bld select (_i % (count _bld));
        _bldPos = _uBld buildingPos -1;
        _pos = _bldPos select (_i % (count _bldPos));
    };
    default {
        _uBld = _bld select (_i % (count _bld));
        _bldPos = _uBld buildingPos -1;
        _pos = _bldPos select (_i % (count _bldPos));
    };
};
_return = [_pos,_uBld];
_return
