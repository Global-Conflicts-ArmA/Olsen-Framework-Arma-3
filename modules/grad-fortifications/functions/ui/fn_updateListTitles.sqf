#include "script_component.hpp"
#include "..\..\dialog\menu\defines.hpp"
#include "..\..\dialog\vehicle\defines.hpp"

params ["_selectedContainer","_canTakeStore"];

disableSerialization;
private _dialog = findDisplay MENU_DIALOG;
private _vehicleTitleCtrl = _dialog displayCtrl VEHICLE_ITEMLISTTITLEVEHICLE;
private _myTitleCtrl = _dialog displayCtrl VEHICLE_ITEMLISTTITLE;

private _builder = ACE_player;

private _interactedContainer = _builder getVariable [QGVAR(currentContainer), objNull];
private _displayName = toUpper ([configFile >> "CfgVehicles" >> (typeOf _interactedContainer) >> "displayName", "text", ""] call CBA_fnc_getConfigEntry);

if (_builder == _selectedContainer) then {
    _myTitleCtrl ctrlSetText (toUpper profileName);
    _vehicleTitleCtrl ctrlSetText (if (_canTakeStore) then {_displayName} else {_displayName + " (NO SPACE)"});
} else {
    _vehicleTitleCtrl ctrlSetText _displayName;
    _myTitleCtrl ctrlSetText (if (_canTakeStore) then {toUpper profileName} else {toUpper profileName + " (NO SPACE)"});
};
