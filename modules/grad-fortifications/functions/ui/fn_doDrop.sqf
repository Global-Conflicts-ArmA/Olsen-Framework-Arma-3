#include "script_component.hpp"
#include "..\..\dialog\menu\defines.hpp"

disableSerialization;
private _dialog = findDisplay MENU_DIALOG;
private _modelCtrl = _dialog displayCtrl MENU_3DMODEL;
private _listCtrl = _dialog displayCtrl MENU_ITEMLIST;

private _curSelID = lnbCurSelRow _listCtrl;
private _type = _listCtrl lnbData [_curSelID,0];

[ACE_player,_type] call FUNC(dropFort);
