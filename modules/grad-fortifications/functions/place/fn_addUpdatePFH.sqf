#include "script_component.hpp"
GVAR(updatePFH) = [{
    params ["_args", "_handle"];
    _args params ["_unit", "_fort", "_surfaceNormal"];

    if (isNull _fort || {!alive _unit} || {currentWeapon _unit != ""}) exitWith {[] call FUNC(cancelPlacement)};

    [_unit, _fort] call FUNC(setPosition);
    [_unit, _fort] call FUNC(setDirection);
    [_unit, _fort, _surfaceNormal] call FUNC(setUp);

},0,_this] call CBA_fnc_addPerFrameHandler;


GVAR(updatePFH)
