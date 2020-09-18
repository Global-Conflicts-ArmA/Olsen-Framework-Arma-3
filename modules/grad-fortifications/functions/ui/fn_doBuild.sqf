#include "script_component.hpp"
#include "..\..\dialog\menu\defines.hpp"
#include "..\..\dialog\vehicle\defines.hpp"

params ["_mode"];

disableSerialization;
private _dialog = findDisplay MENU_DIALOG;
private _modelCtrl = _dialog displayCtrl MENU_3DMODEL;
private _listCtrl = _dialog displayCtrl MENU_ITEMLIST;
private _vehicleListCtrl = _dialog displayCtrl VEHICLE_ITEMLIST;
private _builder = ACE_player;


private _container = _builder getVariable [QGVAR(currentContainer), objNull];
if (isNil "_mode") then {
    if (_builder getVariable [QGVAR(ui_lastSelectedContainer), _builder] == _builder) then {
        _mode = "NORMAL";
    } else {
        _mode = "DROPPED";
    };
};

private _type = if (!isNull _vehicleListCtrl && {(_builder getVariable [QGVAR(ui_lastSelectedContainer), _builder] != _builder)}) then {
    private _curSelID = lnbCurSelRow _vehicleListCtrl;
    _vehicleListCtrl lnbData [_curSelID,0]
} else {
    private _curSelID = lnbCurSelRow _listCtrl;
    _listCtrl lnbData [_curSelID,0]
};

if (_mode == "DROPPED" && {_builder != _container}) then {
    [_builder,_container,_type,"BUILD"] remoteExecCall [QFUNC(respondStoreTake),2,false];
} else {
    [_type,_mode,_builder,_container] call FUNC(startPlacement);
};
