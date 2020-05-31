#include "script_component.hpp"

private _version = 0.1;

["Grad Fortifications", "GRAD Fortifications is an object placement system similar to Plank, but more user friendly for mission creators and players.", "Gruppe-Adler", _version] call EFUNC(FW,RegisterModule);

[] call FUNC(initSettings);

if (hasInterface) then {
    [{
        [] call FUNC(addVehicleInteractions);
        private _action = [QGVAR(mainBuildAction), "Fortifications", "modules\grad-fortifications\data\sandbags.paa", {
            [FUNC(loadFortDialog),[_this select 0, _this select 1]] call CBA_fnc_execNextFrame
        },{
            params ["","_unit"];
            isNull (objectParent _unit) &&
            {!(((_unit getVariable [QGVAR(myFortsHash),[[],0] call CBA_fnc_hashCreate]) select 1) isEqualTo [])} &&
            {!(_unit getVariable [QGVAR(isPlacing), false])}
        }] call ace_interact_menu_fnc_createAction;
        ["CAManBase",1,["ACE_SelfActions","ACE_Equipment"],_action,true] call ace_interact_menu_fnc_addActionToClass;
    }, []] call CBA_fnc_execNextFrame;
};