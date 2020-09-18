#include "script_component.hpp"
#include "..\..\dialog\menu\defines.hpp"

params [["_builder",objNull],"_type",["_mode","NORMAL"],"_pos"];

if (_mode == "NORMAL") then {
    [_builder,_type] call FUNC(removeFort);
};

private _crateType = if (isClass (configfile >> "CfgPatches" >> "CUP_Core")) then {"Fort_Crate_wood"} else {"Land_WoodenCrate_01_F"};
private _crate = createVehicle [_crateType,[0,0,0],[],0,"NONE"];
_crate setDir (random 360);

if (isNil "_pos") then {
    _pos = (_builder getRelPos [2.5,0]) findEmptyPosition [0, 10, _crateType];
    if (count _pos == 0) exitWith {};
    _crate setPos _pos;
} else {
    _crate setPosASL _pos;
};

if (count _pos == 0) exitWith {systemChat "No position found. Fortification added to inventory."; playSound "AddItemFailed"; [_builder,_type] call FUNC(addFort)};
[_crate,_type] remoteExecCall [QFUNC(initDropCrate),0,true];


disableSerialization;
private _dialog = findDisplay MENU_DIALOG;
private _listCtrl = _dialog displayCtrl MENU_ITEMLIST;
[] call FUNC(updateItemList);
