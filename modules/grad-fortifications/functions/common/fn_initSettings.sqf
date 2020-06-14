#include "script_component.hpp"

if (isServer) then {
    GVAR(ConfigCache) = [true] call CBA_fnc_createNamespace;
};

GVAR(canDemolishDefault) = ([(missionConfigFile >> "CfgGradFortifications" >> "canDemolishDefault"),"number",1] call CBA_fnc_getConfigEntry) == 1;
GVAR(canPackUpDefault) = ([(missionConfigFile >> "CfgGradFortifications" >> "canPackUpDefault"),"number",1] call CBA_fnc_getConfigEntry) == 1;
GVAR(buildTimeFactor) = [(missionConfigFile >> "CfgGradFortifications" >> "buildTimeFactor"),"number",1] call CBA_fnc_getConfigEntry;
GVAR(demolishTimeFactor) = [(missionConfigFile >> "CfgGradFortifications" >> "demolishTimeFactor"),"number",1] call CBA_fnc_getConfigEntry;
GVAR(packUpTimeFactor) = [(missionConfigFile >> "CfgGradFortifications" >> "packUpTimeFactor"),"number",1] call CBA_fnc_getConfigEntry;
GVAR(playerInventorySize) = [(missionConfigFile >> "CfgGradFortifications" >> "playerInventorySize"),"number",70] call CBA_fnc_getConfigEntry;
GVAR(boundingBoxSizeFactor) = [(missionConfigFile >> "CfgGradFortifications" >> "boundingBoxSizeFactor"),"number",1] call CBA_fnc_getConfigEntry;
GVAR(vehicleInventorySizeFactor) = ([(missionConfigFile >> "CfgGradFortifications" >> "vehicleInventorySizeFactor"),"number",1] call CBA_fnc_getConfigEntry) max 0;
GVAR(fortificationOwnerType) = [(missionConfigFile >> "CfgGradFortifications" >> "fortificationOwner"),"text","BUILDER"] call CBA_fnc_getConfigEntry;

GVAR(canStoreInLandVehicles) = ([(missionConfigFile >> "CfgGradFortifications" >> "canStoreInLandVehicles"),"number",1] call CBA_fnc_getConfigEntry) == 1;
GVAR(canStoreInShips) = ([(missionConfigFile >> "CfgGradFortifications" >> "canStoreInShips"),"number",1] call CBA_fnc_getConfigEntry) == 1;
GVAR(canStoreInHelicopters) = ([(missionConfigFile >> "CfgGradFortifications" >> "canStoreInHelicopters"),"number",1] call CBA_fnc_getConfigEntry) == 1;
GVAR(canStoreInPlanes) = ([(missionConfigFile >> "CfgGradFortifications" >> "canStoreInPlanes"),"number",1] call CBA_fnc_getConfigEntry) == 1;
GVAR(canStoreInContainers) = ([(missionConfigFile >> "CfgGradFortifications" >> "canStoreInContainers"),"number",1] call CBA_fnc_getConfigEntry) == 1;
