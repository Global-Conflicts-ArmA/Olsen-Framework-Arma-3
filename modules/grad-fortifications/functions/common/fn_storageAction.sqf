#include "script_component.hpp"


private _condition = {
    params [["_vehicle",objNull],["_unit",objNull]];

    alive _vehicle &&
    {!(locked _vehicle in [2,3])} &&
    {isNull (objectParent _unit)} &&
    {!(_vehicle getVariable ["ace_cookoff_isCookingOff",false])} &&
    {!(_unit getVariable [QGVAR(isPlacing), false])} &&
    {
        [
            missionConfigFile >> "CfgGradFortifications" >> "Vehicles" >> typeOf _vehicle,
            "isStorage",
            [0,1] select ([configFile >> "CfgVehicles" >> typeOf (_vehicle),"maximumLoad",-1] call BIS_fnc_returnConfigEntry > 0)
        ] call BIS_fnc_returnConfigEntry > 0
    } &&
    {
        !((((_this select 0) getVariable [QGVAR(myFortsHash),[[],0] call CBA_fnc_hashCreate]) select 1) isEqualTo []) ||
        {!((((_this select 1) getVariable [QGVAR(myFortsHash),[[],0] call CBA_fnc_hashCreate]) select 1) isEqualTo [])}
    }
};

private _onActivate = {
    [GVAR(fnc_loadVehicleDialog),[_this select 0, _this select 1]] call CBA_fnc_execNextFrame;
};

private _action = [QGVAR(containerBuildAction), "Fortifications", "modules\grad-fortifications\data\sandbags.paa",_onActivate,_condition] call ace_interact_menu_fnc_createAction;

_action
