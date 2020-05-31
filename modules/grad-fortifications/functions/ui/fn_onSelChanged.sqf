#include "script_component.hpp"
#include "..\..\dialog\menu\defines.hpp"
#include "..\..\dialog\vehicle\defines.hpp"

params ["_control","_curSel"];
private ["_selectedContainer","_targetContainer"];

if (_curSel < 0) exitWith {};

private _builder = ACE_player;
private _dialog = findDisplay MENU_DIALOG;
private _listCtrl = _dialog displayCtrl MENU_ITEMLIST;
private _vehicleListCtrl = _dialog displayCtrl VEHICLE_ITEMLIST;

private _type = _control lnbData [_curSel,0];
[_control,_type] call FUNC(updateModel);

if (_control == _listCtrl) then {
    _selectedContainer = _builder;
    _targetContainer = _builder getVariable [QGVAR(currentContainer),_builder];
} else {
    _selectedContainer = _builder getVariable [QGVAR(currentContainer),_builder];
    _selectedContainer setVariable [QGVAR(ui_lastSelectedItem), _curSel];
    _targetContainer = _builder;
};

//save last category selection
_builder setVariable [QGVAR(ui_lastSelectedContainer), _selectedContainer];
_builder setVariable [QGVAR(ui_lastSelectedItem), _curSel];

if (!isNull _vehicleListCtrl) then {
    _type = if (_builder == _selectedContainer) then {_listCtrl lnbData [_curSel,0]} else {_vehicleListCtrl lnbData [_curSel,0]};
    private _canTakeStore = [_targetContainer,_type] call FUNC(canTake);

    [_canTakeStore,_builder] call FUNC(updateButtons);
    [_selectedContainer,_canTakeStore] call FUNC(updateListTitles);

    if (_selectedContainer == _builder) then {_vehicleListCtrl lnbSetCurSelRow -1} else {_listCtrl lnbSetCurSelRow -1};
};
