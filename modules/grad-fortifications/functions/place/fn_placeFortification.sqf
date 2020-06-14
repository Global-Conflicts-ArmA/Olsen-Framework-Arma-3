#include "script_component.hpp"
params [["_builder",objNull]];

private _doPlace = {
    params ["_args"];
    _args params ["_builder","_anim"];

    _builder forceWalk false;
    [false] call FUNC(openHint);
    _builder setVariable [QGVAR(isPlacing), false];

    private _fort = _builder getVariable [QGVAR(currentFort), objNull];
    private _spawnParams = [typeOf _fort, getDir _fort, vectorUp _fort, getPosASL _fort, _builder];
    deleteVehicle _fort;
    _spawnParams remoteExecCall [QFUNC(spawnFortification),2,false];

    if (_builder getVariable [QGVAR(currentMode), "NORMAL"] == "NORMAL") then {
        [_builder,_builder getVariable [QGVAR(currentType),""],1] call FUNC(removeFort);
    };
    if (_anim) then {
        [_builder] call FUNC(stopAnimation);
    };
};


if (_builder getVariable [QGVAR(isColliding),true] || {!(_builder getVariable [QGVAR(isOnGround),false])} || {(_builder getVariable [QGVAR(isOnRoad),false])} || {!(_builder getVariable [QGVAR(isCustomCondition),false])}) then {
    playSound "AddItemFailed";

} else {
    [] call FUNC(removeAllEHs);
    [] call ace_interaction_fnc_hideMouseHint;

    private _currentType = typeOf (_builder getVariable [QGVAR(currentFort), objNull]);

    private _objBuildTimeAuto = 3*([_currentType] call FUNC(getObjectSize));
    private _objBuildTime = [_currentType, "buildTime"] call FUNC(getConfigValue);
    private _buildTime = _objBuildTime * (_builder getVariable [QGVAR(buildTimeFactor),GVAR(buildTimeFactor)]);

    if ([_currentType] call FUNC(isVehicle)) then {_buildTime = 0};

    private _onBuildStart = [_currentType, "onBuildStart"] call FUNC(getConfigValue);
    [_builder,_currentType,_builder getVariable [QGVAR(currentFort), objNull]] call compile _onBuildStart;

    if (_buildTime < 1) then {
        [_builder,false] call _doPlace;
    } else {
        [_builder,(configFile >> "ACE_Repair" >> "Actions" >> "FullRepair")] call FUNC(doAnimation);
        [
            _buildTime,
            [_builder,true],
            _doPlace,
            {(_this select 0) call FUNC(stopAnimation); [] call FUNC(cancelPlacement)},
            "Placing..."
        ] call ace_common_fnc_progressBar;
    };
};
