#include "..\..\script_macros.hpp"
AI_EXEC_CHECK(SERVER);

LOG("HC Server Pre Init");

//[QGVAR(ServerEvent), {
//
//}] call CBA_fnc_addEventHandler;

//[QEGVAR(Core,SettingsLoaded), {
//
//}] call CBA_fnc_addEventHandler;

//Gathers HC Arrays
if !(GVAR(ArrayObjects) isEqualTo []) then {
	private _ArrayObjects = GVAR(ArrayObjects);
	LOG_1("ArrayObjects %1",_ArrayObjects);
	[{
		params ["_ArrayObjects"];
		{
            private _arrayName = _x;
			LOG_1("Getting Array data for %1",_arrayName);
            private _logic = missionNamespace getVariable [_arrayName, objnull];
			if !(_logic isEqualTo objnull) then {
				private _entities = [_logic] call FUNC(getSyncedObjects);
				GVAR(zoneEntities) pushBack [_arrayName, _entities];
				_entities params ["_groups", "_emptyVehs", "_objects"];
				LOG_4("Array: %1 Groups: %2 emptyVehs: %3 Objects: %4",_arrayName, count _groups, count _emptyVehs, count _objects);
		    } else {
				LOG_1("Could not find arrayName %1",_arrayName);
			};
		} foreach _ArrayObjects;
		if (isMultiplayer) then {
			[{GVAR(HC_ID) isEqualType 0}, {
				GVAR(HC_ID) publicVariableClient QGVAR(zoneEntities);
			}] call CBA_fnc_waitUntilAndExecute
		};
	}, [_ArrayObjects]] call CBA_fnc_execNextFrame;
};
