#include "script_component.hpp"
#include "..\..\dialog\menu\defines.hpp"
#include "..\..\dialog\vehicle\defines.hpp"

params ["_mode"];

private _dialog = findDisplay MENU_DIALOG;
private _listCtrl = _dialog displayCtrl MENU_ITEMLIST;
private _vehicleListCtrl = _dialog displayCtrl VEHICLE_ITEMLIST;

private _builder = ACE_player;

private _selectedContainer = _builder getVariable [QGVAR(ui_lastSelectedContainer), _builder];
private _currentContainer = _builder getVariable [QGVAR(currentContainer), _builder];
private _type = if (_selectedContainer == _builder) then {
    private _curSel = lnbCurSelRow _listCtrl;
    _listCtrl lnbData [_curSel,0]
} else {
    private _curSel = lnbCurSelRow _vehicleListCtrl;
    _vehicleListCtrl lnbData [_curSel,0]
};

if (_type == "") exitWith {};

switch (_mode) do {
    case ("TAKE"): {
        [_builder,_currentContainer,_type,"TAKE"] remoteExecCall [QFUNC(respondStoreTake),2,false];
    };
    case ("STORE"): {
        [_builder,_type] call FUNC(removeFort);
        [_builder,_currentContainer,_type,"STORE"] remoteExecCall [QFUNC(respondStoreTake),2,false];
    };
};
