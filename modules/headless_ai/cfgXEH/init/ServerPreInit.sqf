#include "..\..\script_macros.hpp"

LOG("HC Server Pre Init");

GVAR(zoneEntities) = [];

//[QGVAR(ServerEvent), {
//
//}] call CBA_fnc_addEventHandler;

//[QEGVAR(Core,SettingsLoaded), {
//
//}] call CBA_fnc_addEventHandler;

[QGVAR(HCRequestArrayDataEvent), {
	params ["_clientOwner"];
	LOG_1("got arrayinfo request from client: %1",_clientOwner);
	[{GETMVAR(ArrayDataChecked,false)}, {
		params ["_clientOwner"];
		LOG_1("sending arrayinfo to client: %1",_clientOwner);
		[QGVAR(HCReceiveArrayDataEvent), GVAR(zoneEntities), _clientOwner] call CBA_fnc_ownerEvent;
	}, [_clientOwner]] call CBA_fnc_waitUntilAndExecute;
}] call CBA_fnc_addEventHandler;

//Gathers HC Arrays
if !(GVAR(ArrayObjects) isEqualTo []) then {
	private _ArrayObjects = GVAR(ArrayObjects);
	LOG_1("ArrayObjects %1",_ArrayObjects);
	[{
		params ["_ArrayObjects"];
		_ArrayObjects apply {
            private _arrayName = _x;
			LOG_1("Getting Array data for %1",_arrayName);
            //private _logic = missionNamespace getVariable [_arrayName, objnull];
            private _logic = missionNamespace getVariable [_x, objNull];
			if (isNull _logic) then {
				LOG_1("Could not find arrayName %1",_arrayName);
		    } else {
				private _synced = [_logic] call FUNC(getSynced);
				if (_synced isEqualTo []) then {
				    ERROR_1("Nothing Synced to %1",_logic);
				} else {
					LOG_2("synced count for %1: %2", _logic, count _synced);
					private _entities = [_synced] call FUNC(getSyncedObjects);
					GVAR(zoneEntities) pushBack [_arrayName, _entities];
					_entities params ["_groups", "_emptyVehs", "_objects"];
					LOG_4("Array: %1 Groups: %2 emptyVehs: %3 Objects: %4",_arrayName, count _groups, count _emptyVehs, count _objects);
				};
			};
		};
	}, [_ArrayObjects]] call CBA_fnc_execNextFrame;
	SETMVAR(ArrayDataChecked,true);
};
