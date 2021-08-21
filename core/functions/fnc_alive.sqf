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

params ["_unit"];

(alive _unit) && {!(_unit getVariable ["FW_Dead", false])}