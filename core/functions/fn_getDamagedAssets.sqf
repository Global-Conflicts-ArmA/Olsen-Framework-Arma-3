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
	if ((GETVAR(_x,AssetTeam,sideEmpty)) isEqualTo _team) then {
        private _assetName = GETVAR(_x,AssetName,typeOf _x);
		if (alive _x) then {
			if (!canMove _x && {!canFire _x} || {_x getHitPointDamage "hitEngine" >= 0.5}) then {
				private _searchIndex = _disabledAssets findIf {(_x select 0) isEqualTo _assetName};
	            if (_searchIndex isEqualTo -1) then {
	                _disabledAssets pushBackUnique [_assetName, 1];
	            } else {
	                _disabledAssets set [_searchIndex, [_assetName, (_disabledAssets select _searchIndex) + 1]];
	            };
			};
		} else {
            private _searchIndex = _destroyedAssets findIf {(_x select 0) isEqualTo _assetName};
            if (_searchIndex isEqualTo -1) then {
                _destroyedAssets pushBackUnique [_assetName, 1];
            } else {
                _destroyedAssets set [_searchIndex, [_assetName, (_destroyedAssets select _searchIndex) + 1]];
            };
		};
	};
} forEach (vehicles select {_x isKindOf "AllVehicles"});

[_disabledAssets, _destroyedAssets]
