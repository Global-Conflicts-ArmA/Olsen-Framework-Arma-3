/*
 * Author: Olsen
 *
 * Outputs disabled and destroyed tracked assets for set team.
 *
 * Arguments:
 * 0: team <string>
 *
 * Return Value:
 * disabled and destroyed assets <array>
 *
 * Public: No
 */

#include "script_component.hpp"

params ["_team"];

private _disabledAssets = [];
private _destroyedAssets = [];

{
	if ((_x getVariable QGVAR(AssetTeam)) isEqualTo _team) then {
		if (alive _x) then {
			if (!canMove _x && {!canFire _x}) then {
				_disabledAssets set [count _disabledAssets, (_x getVariable QGVAR(AssetName)) ];
			};
		} else {
			_destroyedAssets set [count _destroyedAssets, (_x getVariable QGVAR(AssetName)) ];
		};
	};
} forEach vehicles;

_destroyedAssets = _destroyedAssets call FUNC(StackNames);
_disabledAssets = _disabledAssets call FUNC(StackNames);

[_disabledAssets, _destroyedAssets]