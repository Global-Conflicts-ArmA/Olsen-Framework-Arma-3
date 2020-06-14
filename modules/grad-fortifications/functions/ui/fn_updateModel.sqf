/*  Updates item picture
*
*/
#include "script_component.hpp"
#include "..\..\dialog\menu\defines.hpp"
disableSerialization;

params ["_listCtrl","_type"];

private _dialog = findDisplay MENU_DIALOG;
if (isNull _dialog) exitWith {};

private _modelCtrl = _dialog displayCtrl MENU_3DMODEL;

private _modelPath = getText (configfile >> "CfgVehicles" >> _type >> "model");
private _modelSize = [_type] call FUNC(getObjectSize);
private _modelScale = 1/_modelSize * 0.65;

_modelCtrl ctrlSetModel _modelPath;
_modelCtrl ctrlSetModelScale _modelScale;

_modelCtrl ctrlCommit 0;
