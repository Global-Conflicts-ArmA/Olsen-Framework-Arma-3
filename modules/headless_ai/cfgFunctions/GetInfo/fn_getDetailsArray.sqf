#include "..\..\script_macros.hpp"


params [
    "_classname",
    "_array",
    ["_keycolumn",0,[0]],
    ["_value",-1,[0]]
];
{
    if ((_x select _keycolumn) isEqualTo _classname) exitwith {
        _value = _foreachIndex;
    };
} foreach _array;
_value
