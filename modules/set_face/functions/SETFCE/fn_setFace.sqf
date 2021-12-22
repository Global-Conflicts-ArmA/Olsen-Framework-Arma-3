#include "script_component.hpp"

params ["_unit"];

GVAR(setFace_special) params ["_special_face", "_special_unit"];

if (_unit in _special_unit) then {
	private _face = selectRandom _special_face;
	[_unit, _face] remoteExec ["setFace", 0, _unit];
} else {
	private _face = switch (side _unit) do {
		case west: {
			selectRandom GVAR(setFace_west)
		};
		case east: {
			selectRandom GVAR(setFace_east)
		};
		case independent: {
			selectRandom GVAR(setFace_guer)
		};
		default {
			selectRandom GVAR(setFace_civ)
		};
	};
    [_unit, _face] remoteExec ["setFace", 0, _unit];
};
