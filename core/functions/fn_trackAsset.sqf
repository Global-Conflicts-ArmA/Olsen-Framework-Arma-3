/*
 * Author: Olsen
 *
 * Assigns name and team info to an asset.
 *
 * Arguments:
 * 0: asset <object>
 * 1: name <string>
 * 2: team <string>
 *
 * Return Value:
 * nothing
 *
 * Public: Yes
 */

#include "script_component.hpp"

params [
	["_asset", objNull, [objNull]],
	["_name", "", [""]],
	["_team", "", [""]]
];

private _asset = vehicle (_asset);

_asset setVariable [QGVAR(AssetName), _name];
_asset setVariable [QGVAR(AssetTeam), _team];