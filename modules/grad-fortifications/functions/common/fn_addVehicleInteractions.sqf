#include "script_component.hpp"
private _action = [] call FUNC(storageAction);

if (GETMVAR(canStoreInLandVehicles,true)) then {
    ["LandVehicle",0,["ACE_MainActions"],_action,true] call ace_interact_menu_fnc_addActionToClass;
};
if (GETMVAR(canStoreInShips,true)) then {
    ["Ship",0,["ACE_MainActions"],_action,true] call ace_interact_menu_fnc_addActionToClass;
};
if (GETMVAR(canStoreInHelicopters,true)) then {
    ["Helicopter",0,["ACE_MainActions"],_action,true] call ace_interact_menu_fnc_addActionToClass;
};
if (GETMVAR(canStoreInPlanes,true)) then {
    ["Plane",0,["ACE_MainActions"],_action,true] call ace_interact_menu_fnc_addActionToClass;
};
if (GETMVAR(canStoreInContainers,true)) then {
    ["ThingX",0,["ACE_MainActions"],_action,true] call ace_interact_menu_fnc_addActionToClass;
};
