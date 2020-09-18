#include "script_component.hpp"
#include "..\..\dialog\menu\defines.hpp"

params ["_container","_caller"];

disableSerialization;
createDialog QGVAR(MainMenu);
private _dialog = findDisplay MENU_DIALOG;
private _modelCtrl = _dialog displayCtrl MENU_3DMODEL;
private _listCtrl = _dialog displayCtrl MENU_ITEMLIST;
private _titleCtrl = _dialog displayCtrl MENU_TITLE;
private _buildCtrl = _dialog displayCtrl MENU_BUILDBUTTON;
private _takeCtrl = _dialog displayCtrl MENU_DROPBUTTON;

_caller setVariable [QGVAR(currentContainer), _container];
[_container] call FUNC(updateItemList);
