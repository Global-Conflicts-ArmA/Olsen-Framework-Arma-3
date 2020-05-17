/*
 * Author: Olsen
 *
 * Add module to list.
 *
 * Arguments:
 * 0: name <string>
 * 1: description <string>
 * 2: author <string>
 *
 * Return Value:
 * nothing
 *
 * Public: Yes
 */

#include "..\script_macros.hpp"

params ["_name", "_description", "_author", ["_version", 0, [0]]];

GVAR(Modules) set [count GVAR(Modules), [_name, _description, _author, _version]];