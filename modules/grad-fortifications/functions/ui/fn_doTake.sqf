#include "script_component.hpp"
#include "..\..\dialog\menu\defines.hpp"

disableSerialization;
private _dialog = findDisplay MENU_DIALOG;
private _modelCtrl = _dialog displayCtrl MENU_3DMODEL;
private _listCtrl = _dialog displayCtrl MENU_ITEMLIST;

private _builder = ACE_player;

private _curSelID = lnbCurSelRow _listCtrl;
private _type = _listCtrl lnbData [_curSelID,0];
private _container = _builder getVariable [QGVAR(currentContainer), objNull];

[_container,_type] call FUNC(removeFort);
[_builder,_type] call FUNC(addFort);
[_container] call FUNC(updateItemList);
