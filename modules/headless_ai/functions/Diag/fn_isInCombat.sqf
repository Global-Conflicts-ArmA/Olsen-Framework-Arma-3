#include "script_component.hpp"

params ["_group"];

private _leader = leader _group;
private _assignedTarget = assignedTarget _leader;
private _setTarget = _group getVariable [QGVAR(CurrentTarget), objNull];

private _combat = if (
    _assignedTarget isNotEqualTo objNull ||
    _setTarget isNotEqualTo objNull
) then {
    true
} else {
    false
};

_combat
