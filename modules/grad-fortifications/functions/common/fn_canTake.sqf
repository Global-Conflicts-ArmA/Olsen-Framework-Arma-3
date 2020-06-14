#include "script_component.hpp"
params ["_unit","_type",["_amount",1],["_showMessage",false]];

private _inventoryCargo = _unit getVariable [QGVAR(inventoryCargo),0];
private _inventorySpace = (_unit getVariable [QGVAR(inventorySize),[_unit] call FUNC(getVehicleInventorySize)]) - _inventoryCargo;
private _size = [_type, "size"] call FUNC(getConfigValue);

private _canTake = if ((_size*_amount) > _inventorySpace) then {false} else {true};

if (_showMessage && {!_canTake}) then {
    systemChat format ["Not enough space in inventory: (%1/%2) - required: %3", round _inventoryCargo,_inventorySpace,round _size];
};

_canTake
