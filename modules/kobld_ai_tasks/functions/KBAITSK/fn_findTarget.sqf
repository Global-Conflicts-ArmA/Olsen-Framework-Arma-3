#include "script_component.hpp"

params ["_group","_range"];

private _newDist = _range;

private _all = (leader _group) nearEntities ["Man", _range];

_all = _all select {
	alive _x && {side _x != civilian} && {side _x != side _group} && {typeOf _x != "HeadlessClient_F"} && {!(_x isKindOf "Air")};
};

private _target = objNull;

_all apply {
	private _distance = (leader _group) distance2d _x;

	if (_distance < _newDist && {getpos _x select 2 < 200}) then {
		_target = _x;
		_newDist = _distance;
	};
};

_target
