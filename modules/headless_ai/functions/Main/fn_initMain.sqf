#include "script_component.hpp"

//Basic Vars
GVAR(BasicCheckCurrent) = 0;
GVAR(LeaderExecuteCurrent) = 0;
GVAR(MarkerArray) = [];
GVAR(markerTrackedGroups) = createHashMap;
GVAR(OccupiedPositions) = [];

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
    //Commander Functions
    if (GVAR(CommanderEnabled)) then {
        GVAR(CommanderAssets) = [];
    	[] call FUNC(CommanderInit);
    };
	[] call FUNC(GroupHandler);
    if (GETMVAR(UseMarkers,false)) then {
        [] call FUNC(MapMarkers);
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

if ((GVAR(InitialRandomSpawnsCount) >= 1) && {(GVAR(InitialRandomSpawns) isNotEqualTo [])}) then {
	//construct InitialRandomSpawns array
	private _initialRandomSpawns = [];
	{
	    if (_x isEqualType "") then {
            private _arrayName = _x;
            private _weight = GVAR(InitialRandomSpawns) deleteAt (_forEachIndex + 1);
            _initialRandomSpawns pushBack _arrayName;
    		_initialRandomSpawns pushBack _weight;
        };
	} forEach GVAR(InitialRandomSpawns);
	LOG_1("InitialRandomSpawns %1",_initialRandomSpawns);
	[{
		params ["_initialRandomSpawns"];
		private _initialRandomSpawnsSelected = [];
		for "_a" from 1 to (GETMVAR(InitialRandomSpawnsCount,1)) step 1 do {
		    private _selected = selectRandomWeighted _initialRandomSpawns;
			_index = _initialRandomSpawns find _selected;
			_initialRandomSpawnsSelected pushBackUnique _selected;
			_initialRandomSpawns deleteRange [_index, 2];
		};
		if (_initialRandomSpawnsSelected isNotEqualTo []) then {
			[{
				params ["_initialRandomSpawnsSelected"];
				{
					private _logic = missionNamespace getVariable [_x, objNull];
					if (isNull _logic) then {
						ERROR_MSG_1("Could not find arrayName %1",_x);
				    } else {
						_x call FUNC(spawnArray);
					};
				} foreach _initialRandomSpawnsSelected;
			}, [_initialRandomSpawnsSelected]] call CBA_fnc_execNextFrame;
		};
	}, [_initialRandomSpawns]] call CBA_fnc_execNextFrame;
};

//ForceTime
if (!(hasInterface) && {!(isServer)}) then {
	setViewDistance GVAR(AIViewDistance);
	setTerrainGrid (GETMVAR(AITerrainDetail,3.125));
	if (GVAR(ForceTimeEnable)) then {
		private _forcedDate = [date select 0, date select 1, date select 2, GVAR(ForceTime) select 0, GVAR(ForceTime) select 1];
		GVAR(TimeHandlePFH) = [{
			params ["_argNested", "_idPFH"];
			_argNested params ["_forcedDate"];
			setdate _forcedDate;
		}, 1, [_forcedDate]] call CBA_fnc_addPerFrameHandler;
	};
};
