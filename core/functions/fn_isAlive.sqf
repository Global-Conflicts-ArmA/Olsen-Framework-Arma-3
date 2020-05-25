/*
 * Author: Olsen
 *
 * Checks if unit is considered alive by framework
 *
 * Arguments:
 * 0: unit <object>
 *
 * Return Value:
 * is alive <bool>
 *
 * Public: Yes
 */

#include "script_component.hpp"

params ["_unit"];

private _return = !(isNull _unit) && {alive _unit} && {!(GETVAR(_unit,Dead,false))};

_return
