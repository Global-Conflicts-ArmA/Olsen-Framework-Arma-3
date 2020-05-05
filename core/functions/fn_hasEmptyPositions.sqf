/*
 * Author: Olsen
 *
 * Checks if vehicle has available positions
 *
 * Arguments:
 * 0: vehicle <object>
 *
 * Return Value:
 * has empty positions <bool>
 *
 * Public: Yes
 */

#include "..\script_macros.hpp"

params ["_vehicle"];

(_vehicle emptyPositions "Cargo" != 0 || {_vehicle emptyPositions "Gunner" != 0} || {_vehicle emptyPositions "Commander" != 0} || {_vehicle emptyPositions "Driver" != 0})
