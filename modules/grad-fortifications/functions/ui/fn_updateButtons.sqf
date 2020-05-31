#include "script_component.hpp"
#include "..\..\dialog\menu\defines.hpp"
#include "..\..\dialog\vehicle\defines.hpp"

params ["_canTakeStore","_builder"];

private _dialog = findDisplay MENU_DIALOG;
private _takeButton = _dialog displayCtrl VEHICLE_TAKEBUTTON;
private _storeButton = _dialog displayCtrl VEHICLE_STOREBUTTON;
private _listCtrl = _dialog displayCtrl MENU_ITEMLIST;
private _vehicleListCtrl = _dialog displayCtrl VEHICLE_ITEMLIST;

private _selectedContainer = _builder getVariable [QGVAR(ui_lastSelectedContainer), _builder];

private _takeButtonEnable = switch (true) do {
    case (_selectedContainer == _builder): {false};
    case (!_canTakeStore): {false};
    case (lnbSize _vehicleListCtrl select 0 == 0): {false};
    default {true};
};

private _storeButtonEnable = switch (true) do {
    case (_selectedContainer != _builder): {false};
    case (!_canTakeStore): {false};
    case (lnbSize _listCtrl select 0 == 0): {false};
    default {true};
};

_takeButton ctrlEnable _takeButtonEnable;
_storeButton ctrlEnable _storeButtonEnable;
