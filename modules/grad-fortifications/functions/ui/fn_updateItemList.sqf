/*  Updates itemlist based on chosen category
*
*/

#include "script_component.hpp"

#include "..\..\dialog\menu\defines.hpp"
#include "..\..\dialog\vehicle\defines.hpp"

private _builder = ACE_player;

params [["_container",_builder getVariable [QGVAR(currentContainer), _builder]],"_containerFortsHash"];
private ["_containerFortsHash"];

disableSerialization;

if (_builder getVariable [QGVAR(currentContainer), _builder] != _container && {_builder !=_container}) exitWith {};

private _dialog = findDisplay MENU_DIALOG;
private _listCtrl = _dialog displayCtrl MENU_ITEMLIST;
private _vehicleListCtrl = _dialog displayCtrl VEHICLE_ITEMLIST;
if (isNull _listCtrl) exitWith {};

if !([_builder getVariable [QGVAR(myFortsHash),[[],0] call CBA_fnc_hashCreate]] call CBA_fnc_isHash) exitWith {ERROR("Unit does not have myFortsHash.")};

private _myFortsHash = _builder getVariable [QGVAR(myFortsHash),[[],0] call CBA_fnc_hashCreate];
if (isNil "_containerFortsHash") then {
    _containerFortsHash = _container getVariable [QGVAR(myFortsHash),[[],0] call CBA_fnc_hashCreate];
};


{
    _x params ["_control", "_hash"];
    if (isNull _control) exitWith {};
    lnbClear _control;
    private _listIndex = 0;
    private _updateList = {
        private _displayName = [_key] call FUNC(getDisplayName);

        if (_value > 0) then {
            _control lnbAddRow [str _value, _displayName];
            _control lnbSetData [[_listIndex,0], _key];
            _listIndex = _listIndex + 1;
        };
    };
    [_hash, _updateList] call CBA_fnc_hashEachPair;
    false
} count [[_listCtrl,_myFortsHash],[_vehicleListCtrl,_containerFortsHash]];

private _itemCount = if (isNull _vehicleListCtrl) then {lnbSize _listCtrl select 0} else {(lnbSize _listCtrl select 0) + (lnbSize _vehicleListCtrl select 0)};
if (_itemCount == 0) exitWith {closeDialog MENU_DIALOG};

private _lastSelectedContainer = _builder getVariable [QGVAR(ui_lastSelectedContainer), _builder];
private _listToSelect = switch (true) do {
    case (isNull _vehicleListCtrl): {0};
    case ((lnbSize _listCtrl select 0) == 0): {1};
    case (_lastSelectedContainer == _builder): {0};
    case ((lnbSize _vehicleListCtrl select 0) == 0): {0};
    default {1};
};

if (_listToSelect == 0) then {
    private _lastSel = _builder getVariable [QGVAR(ui_lastSelectedItem),0];
    private _curSel = if (_lastSel > (lnbSize _listCtrl select 0)) then {0} else {_lastSel};
    _listCtrl lnbSetCurSelRow _curSel;
} else {
    private _lastSel = _container getVariable [QGVAR(ui_lastSelectedItem),0];
    private _curSel = if (_lastSel > (lnbSize _vehicleListCtrl select 0)) then {-1} else {_lastSel};
    _vehicleListCtrl lnbSetCurSelRow _curSel;
};
