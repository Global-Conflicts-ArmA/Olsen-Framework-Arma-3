// Author: StatusRed
#include "script_component.hpp"

/**
 * FW_fnc_FIREMIS_DoConstantArtillery
 * Commands a battery to constantly fire artillery at a marker target with unliminted ammo until the battery is destroyed.
 * Author: StatusRed
 *
 * Parameters:
 * 0: unit - The unit to command fire
 * 1: target - The target to fire at
 * 2: dispersion - How close to the target to fire within
 * 3: minDelay - The minimum delay between firing (in seconds)
 * 4: delayModifier - A range from 0 to the delay modifier value (in seconds) is added to the minimum delay
*/
params[
  ["_unit", objNull, [objNull]],
  ["_target", objNull, ["", objNull, []]],
  ["_dispersion", 100, [100]],
  ["_minDelay", 60, [60]],
  ["_delayModifier", 61, [61]]
];

if (isServer) then {
  [_unit, -1, -1, -1, -1, -1, "Constant Artillery", true] call FUNC(FIREMIS_SetArtilleryData);

  [{
    params["_args", "_idPFH"];
    _args params ["_unit", "_target", "_dispersion", "_delayModifier"];

    if !(alive _unit) exitWith {
      [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

    private _delay = floor (random _delayModifier);
    [{
      params ["_unit", "_target", "_dispersion"];

      [_unit, _target, 1, 2, 1, _dispersion, 0] call FUNC(FIREMIS_MarkerFiremission);
    }, [_unit, _target, _dispersion], _delay] call CBA_fnc_waitAndExecute;
  }, _minDelay, [_unit, _target, _dispersion, _delayModifier]] call CBA_fnc_addPerFrameHandler;
};
