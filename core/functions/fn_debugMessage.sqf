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

#include "script_component.hpp"

params [["_message", "", [""]]];

if (GVAR(DebugMessages) findIf {_x isEqualTo _message} isNotEqualTo -1) then {
	GVAR(DebugMessages) pushBackUnique _message;
};
