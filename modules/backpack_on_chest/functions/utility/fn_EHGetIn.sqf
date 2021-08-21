/*
 * Author: DerZade
 * Triggerd by GetInMan-Eventhandler
 *
 * Arguments:
 * 0: unit <OBJECT>
 * 1: position <STRING>
 * 2: vehicle <OBJECT>
 * 3: turret path <ARRAY>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * _this call zade_boc_fnc_EHGetIn;
 *
 * Public: No
 */
params ["_unit","_position","_veh"];

if (isNil "_unit" or isNil "_veh") exitWith {["No proper argument(s) given."] call BIS_fnc_error};

private _chestpack = [_unit] call zade_boc_fnc_chestpackContainer;

_chestpack remoteExec ["detach", 0];
_chestpack remoteExec ["hideObjectGlobal", 0];
[_chestpack, [-10000,-10000,-100]] remoteExec ["setPos", 0];
