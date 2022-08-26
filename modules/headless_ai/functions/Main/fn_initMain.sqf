#include "script_component.hpp"

//Basic Vars
GVAR(BasicCheckCurrent) = 0;
GVAR(LeaderExecuteCurrent) = 0;
GVAR(MarkerArray) = [];
GVAR(markerTrackedGroups) = createHashMap;


//StateMachines
LOG("creating bunkerStateMachine");
GVAR(bunkerStateMachineHandler) = (missionConfigFile >> QGVAR(bunkerStateMachine)) call FUNC(createFromConfig);
//LOG("creating commanderStateMachine");
//GVAR(commanderStateMachineHandler) = (missionConfigFile >> QGVAR(commanderStateMachine)) call CBA_statemachine_fnc_createFromConfig;
if (GVAR(SightAidFeature)) then {
    LOG("creating sightAidStateMachine");
    GVAR(sightAidStateMachineHandler) = (missionConfigFile >> QGVAR(sightAidStateMachine)) call CBA_statemachine_fnc_createFromConfig;
};
if (GVAR(cacheFeature)) then {
    LOG("creating cachingStateMachine");
    GVAR(cachingStateMachineHandler) = (missionConfigFile >> QGVAR(cachingStateMachine)) call CBA_statemachine_fnc_createFromConfig;
};
if (GVAR(stanceFeature)) then {
    LOG("creating unitStanceStateMachine");
    GVAR(unitStanceStateMachineHandler) = (missionConfigFile >> QGVAR(unitStanceStateMachine)) call CBA_statemachine_fnc_createFromConfig;
};


//Main Functions
[{
	[] call FUNC(GroupHandler);
    if (GETMVAR(UseMarkers,false)) then {
        [] call FUNC(MapMarkers);
    };
    //Commander Functions
    if (GVAR(CommanderEnabled)) then {
    	[] call FUNC(CommanderInit);
    };
}, []] call CBA_fnc_execNextFrame;

//Spawns initial HC arrays
if (GVAR(InitialSpawn) isNotEqualTo []) then {
	private _InitialSpawn = GVAR(InitialSpawn);
	LOG_1("InitialSpawn %1",_InitialSpawn);
	[{
		params ["_InitialSpawn"];
		[{
			params ["_InitialSpawn"];
			{
				private _logic = missionNamespace getVariable [_x, objNull];
				if (isNull _logic) then {
					LOG_1("Could not find arrayName %1",_x);
			    } else {
					_x call FUNC(spawnArray);
				};
			} foreach _InitialSpawn;
		}, [_InitialSpawn]] call CBA_fnc_execNextFrame;
	}, [_InitialSpawn]] call CBA_fnc_execNextFrame;
};

if ((GVAR(InitialRandomSpawnsCount) > 1) && {(GVAR(InitialRandomSpawns) isNotEqualTo [])}) then {
	//construct InitialRandomSpawns array
	private _InitialRandomSpawns = [];
	{
	    _x params ["_element", "_weight"];
		_InitialRandomSpawns pushBack _element;
		_InitialRandomSpawns pushBack _weight;
	} forEach GVAR(InitialRandomSpawns);
	LOG_1("InitialRandomSpawns %1",_InitialRandomSpawns);
	[{
		params ["_InitialRandomSpawns"];
		private _InitialRandomSpawnsSelected = [];
		for "_a" from 0 to (GETMVAR(InitialRandomSpawnsCount,1)) step 1 do {
		    private _selected = selectRandomWeighted _InitialRandomSpawns;
			_InitialRandomSpawnsSelected pushBack _selected;
			_InitialRandomSpawns - [_selected];
		};
		if (GVAR(_InitialRandomSpawnsSelected) isNotEqualTo []) then {
			[{
				params ["_InitialRandomSpawnsSelected"];
				{
					private _logic = missionNamespace getVariable [_x, objNull];
					if (isNull _logic) then {
						LOG_1("Could not find arrayName %1",_x);
				    } else {
						_x call FUNC(spawnArray);
					};
				} foreach _InitialRandomSpawnsSelected;
			}, [_InitialRandomSpawnsSelected]] call CBA_fnc_execNextFrame;
		};
	}, [_InitialRandomSpawns]] call CBA_fnc_execNextFrame;
};

//ForceTime
if (!(hasInterface) && {!(isServer)}) then {
	setViewDistance GVAR(AIViewDistance);
	setTerrainGrid 6.25;
	if (GVAR(ForceTimeEnable)) then {
		private _forcedDate = [date select 0, date select 1, date select 2, GVAR(ForceTime) select 0, GVAR(ForceTime) select 1];
		GVAR(TimeHandlePFH) = [{
			params ["_argNested", "_idPFH"];
			_argNested params ["_forcedDate"];
			setdate _forcedDate;
		}, 1, [_forcedDate]] call CBA_fnc_addPerFrameHandler;
	};
};
