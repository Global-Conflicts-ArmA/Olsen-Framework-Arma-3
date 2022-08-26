#include "script_component.hpp"


params[
    ["_s",0,[0]],
    ["_t","OBJECT",[""]],
    ["_a",1,[0]],
    "_var",
    ["_array",[],[[]]]
];
if ((_array select _s) isEqualType _t ) then {
    _array deleteAt 0;
};
_array set [_a,_var];
_array set [2,0];
private _wp = _array call FUNC(createWaypoint);
true
