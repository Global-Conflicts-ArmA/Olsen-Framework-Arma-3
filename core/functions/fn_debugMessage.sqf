/*
 * Author: Olsen
 *
 * Display a debug message.
 * Must be ran during init in order to work properly.
 *
 * Arguments:
 * 0: message <string>
 *
 * Return Value:
 * nothing
 *
 * Public: No
 */

#include "..\script_macros.hpp"

params ["_message"];

private _found = false;

{
	if (_x isEqualTo _message) exitWith {
		_found = true;
	};
} forEach GVAR(DebugMessages);

if !(_found) then {
	GVAR(DebugMessages) set [count GVAR(DebugMessages), _message];
};