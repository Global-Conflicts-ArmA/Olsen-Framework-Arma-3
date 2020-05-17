#include "..\..\script_macros.hpp"


params [
    "_classname",
    "_array",
    ["_keycolumn",0,[0]],
    ["_value",[],[[]]]
];

for "_i" from 0 to (count _array) step 1 do {
    if ((_array select _i select _keycolumn) == _classname) exitwith {
        _value = _array select _i;
    };
};
_value
