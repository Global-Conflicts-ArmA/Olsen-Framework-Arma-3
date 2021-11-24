#include "script_component.hpp"

params [
	["_side", sideUnknown, [sideUnknown]],
	["_coc", [], [[]]]
];

GVAR(COC) pushBack [_side, _coc];
