#include "script_component.hpp"
#include "..\..\dialog\menu\defines.hpp"
#include "..\..\dialog\vehicle\defines.hpp"

params ["_container","_caller"];

_caller setVariable [QGVAR(currentContainer), _container];

disableSerialization;
createDialog QGVAR(vehicle);
private _dialog = findDisplay MENU_DIALOG;
private _modelCtrl = _dialog displayCtrl MENU_3DMODEL;
private _listCtrl = _dialog displayCtrl MENU_ITEMLIST;

[_container] call FUNC(updateItemList);
[_caller,true] call FUNC(updateListTitles);
