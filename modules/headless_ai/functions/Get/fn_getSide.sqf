#include "script_component.hpp"


params [["_select",0,[0]],["_side",[],[[]]]];
switch (_select) do {
    case 0: { _side = [WEST]; };
    case 1: { _side = [EAST]; };
    case 2: { _side = [INDEPENDENT]; };
    case 3: { _side = [CIVILIAN]; };
    case 4: { _side = [WEST,EAST,INDEPENDENT,CIVILIAN]; };
    case 5: { _side = [WEST,EAST]; };
    case 6: { _side = [WEST,INDEPENDENT]; };
    case 7: { _side = [WEST,CIVILIAN]; };
    case 8: { _side = [WEST,EAST,INDEPENDENT]; };
    case 9: { _side = [WEST,INDEPENDENT,CIVILIAN]; };
    case 10: { _side = [EAST,INDEPENDENT]; };
    case 11: { _side = [EAST,CIVILIAN]; };
    case 12: { _side = [EAST,INDEPENDENT,CIVILIAN]; };
    case 13: { _side = [INDEPENDENT,CIVILIAN]; };
    default {[WEST]};
};
_side
