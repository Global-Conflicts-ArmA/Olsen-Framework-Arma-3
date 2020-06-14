#include "script_component.hpp"
params ["_type", ["_mode", "NORMAL"], ["_builder", ACE_player], ["_container", objNull]];

if (_type isEqualTo "" || {(ACE_player != _builder)}) exitWith {};

private _boundingBoxSize = [_type, "boundingBoxSize"] call FUNC(getConfigValue);
private _boundingBoxOffset = [_type, "boundingBoxOffset"] call FUNC(getConfigValue);
private _minHeight = [_type, "minHeight"] call FUNC(getConfigValue);
private _maxHeight = [_type, "maxHeight"] call FUNC(getConfigValue);
private _canFloat = [_type, "canFloat"] call FUNC(getConfigValue);
private _canCollide = [_type, "canCollide"] call FUNC(getConfigValue);
private _canPlaceOnRoad = [_type, "canPlaceOnRoad"] call FUNC(getConfigValue);
private _surfaceNormal = [_type, "surfaceNormal"] call FUNC(getConfigValue);
private _surfaceNormalForced = [_type, "surfaceNormalForced"] call FUNC(getConfigValue);
private _onPlaceStart = [_type, "onPlaceStart"] call FUNC(getConfigValue);

private _fort = _type createVehicleLocal [0,0,0];
private _size = [_type] call FUNC(getObjectSize);
_fort allowDamage false;
_fort enableSimulation false;
_fort disableCollisionWith _builder;
_fort disableCollisionWith _container;

[_builder,_type,_fort] call compile _onPlaceStart;

if (missionNamespace getVariable [QGVAR(collisionDebugMode),false]) then {
    _fort hideObject true;
};

_builder setVariable [QGVAR(isPlacing), true];
_builder setVariable [QGVAR(currentType), _type];
_builder setVariable [QGVAR(currentFort), _fort];
_builder setVariable [QGVAR(currentMode), _mode];
_builder setVariable [QGVAR(currentSize), _size];
_builder setVariable [QGVAR(currentDistance), (((_size*2.5)^(1/2)) max 2)];
_builder setVariable [QGVAR(currentDirection), 0];
_builder setVariable [QGVAR(currentHeight),(0 max _minHeight) min _maxHeight];
_builder setVariable [QGVAR(minHeight),_minHeight];
_builder setVariable [QGVAR(maxHeight),_maxHeight];
_builder setVariable [QGVAR(surfaceNormal),_surfaceNormal];
_builder setVariable [QGVAR(surfaceNormalForced),_surfaceNormalForced];

_builder call ace_common_fnc_fixLoweredRifleAnimation;
[_builder] call ace_weaponselect_fnc_putWeaponAway;
_builder forceWalk true;

[true, _surfaceNormal] call FUNC(openHint);

private _boundingLines = [_fort,_boundingBoxSize,_boundingBoxOffset] call FUNC(getBoundingLines);
private _visualLines = [_fort] call FUNC(getVisualLines);
private _groundLines = [_fort] call FUNC(getGroundLines);
[_builder,_visualLines,_boundingLines,_groundLines,_fort,_canFloat,_canCollide,_canPlaceOnRoad,_surfaceNormal,_surfaceNormalForced] call FUNC(checkCollisionPFH);


[_builder, _fort, _surfaceNormal] call FUNC(addUpdatePFH);
[] call FUNC(addMouseEHs);
[] call FUNC(addKeyEHs);

["Place", "Cancel", "Manipulate"] call ace_interaction_fnc_showMouseHint;
