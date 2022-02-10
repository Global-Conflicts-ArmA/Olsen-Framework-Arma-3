#include "script_component.hpp"

LOG("HC Global Pre Init");

GVAR(ArrayObjects) = [missionConfigFile >> QGVAR(settings) >> "arrayObjects", "array", []] call CBA_fnc_getConfigEntry;
GVAR(InitialSpawn) = [missionConfigFile >> QGVAR(settings) >> "initialSpawn", "array", []] call CBA_fnc_getConfigEntry;
GVAR(InitialRandomSpawnsCount) = [missionConfigFile >> QGVAR(settings) >> "initialRandomSpawnsCount", "number", 0] call CBA_fnc_getConfigEntry;

GVAR(debug) = ([missionConfigFile >> QGVAR(settings) >> "debug", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(verboseDebug) = ([missionConfigFile >> QGVAR(settings) >> "verboseDebug", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(groupDebug) = ([missionConfigFile >> QGVAR(settings) >> "groupDebug", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(useMarkers) = ([missionConfigFile >> QGVAR(settings) >> "useMarkers", "number", 1] call CBA_fnc_getConfigEntry) == 1;

GVAR(AIViewDistance) = [missionConfigFile >> QGVAR(settings) >> "AIViewDistance", "number", 2500] call CBA_fnc_getConfigEntry;

GVAR(forceTimeEnable) = ([missionConfigFile >> QGVAR(settings) >> "forceTimeEnable", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(forceTime) = [missionConfigFile >> QGVAR(settings) >> "forceTime", "array", []] call CBA_fnc_getConfigEntry;

GVAR(feature) = ([missionConfigFile >> QGVAR(settings) >> "feature", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(enemyUpdateFrequency) = [missionConfigFile >> QGVAR(settings) >> "enemyUpdateFrequency", "number", 5] call CBA_fnc_getConfigEntry;
GVAR(stateMachineFrames) = [missionConfigFile >> QGVAR(settings) >> "stateMachineFrames", "number", 4] call CBA_fnc_getConfigEntry;
GVAR(saferVehSpawning) = ([missionConfigFile >> QGVAR(settings) >> "cacheAllPlayers", "number", 0] call CBA_fnc_getConfigEntry) == 1;

GVAR(cacheFeature) = ([missionConfigFile >> QGVAR(settings) >> "cacheFeature", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(cacheDisableDistance) = [missionConfigFile >> QGVAR(settings) >> "cacheDisableDistance", "number", 3000] call CBA_fnc_getConfigEntry;
GVAR(cacheAllPlayers) = ([missionConfigFile >> QGVAR(settings) >> "cacheAllPlayers", "number", 1] call CBA_fnc_getConfigEntry) == 1;

GVAR(stanceFeature) = ([missionConfigFile >> QGVAR(settings) >> "stanceFeature", "number", 1] call CBA_fnc_getConfigEntry) == 1;

GVAR(hearingDistance) = [missionConfigFile >> QGVAR(settings) >> "hearingDistance", "number", 2000] call CBA_fnc_getConfigEntry;
GVAR(hearingMinIncrease) = [missionConfigFile >> QGVAR(settings) >> "hearingMinIncrease", "number", 1] call CBA_fnc_getConfigEntry;
GVAR(radioDistance) = [missionConfigFile >> QGVAR(settings) >> "radioDistance", "number", 0] call CBA_fnc_getConfigEntry;
GVAR(radioWait) = [missionConfigFile >> QGVAR(settings) >> "radioWait", "number", 30] call CBA_fnc_getConfigEntry;
GVAR(radioNeedRadio) = ([missionConfigFile >> QGVAR(settings) >> "radioNeedRadio", "number", 0] call CBA_fnc_getConfigEntry) == 1;
GVAR(patrolDistance) = [missionConfigFile >> QGVAR(settings) >> "patrolDistance", "number", 200] call CBA_fnc_getConfigEntry;
GVAR(garrisonPatrol) = ([missionConfigFile >> QGVAR(settings) >> "garrisonPatrol", "number", 0] call CBA_fnc_getConfigEntry) == 1;
GVAR(reinforce) = ([missionConfigFile >> QGVAR(settings) >> "reinforce", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(reinforceDistance) = [missionConfigFile >> QGVAR(settings) >> "reinforceDistance", "number", 2500] call CBA_fnc_getConfigEntry;
GVAR(QRF_Distance) = [missionConfigFile >> QGVAR(settings) >> "QRF_Distance", "number", 2500] call CBA_fnc_getConfigEntry;
GVAR(mountStatics) = ([missionConfigFile >> QGVAR(settings) >> "mountStatics", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(mountStaticsDistance) = [missionConfigFile >> QGVAR(settings) >> "mountStaticsDistance", "number", 50] call CBA_fnc_getConfigEntry;
GVAR(usesmoke) = ([missionConfigFile >> QGVAR(settings) >> "usesmoke", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(grenadechance) = [missionConfigFile >> QGVAR(settings) >> "grenadechance", "number", 45] call CBA_fnc_getConfigEntry;
GVAR(AIDisembark) = ([missionConfigFile >> QGVAR(settings) >> "AIDisembark", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(AIMagLimit) = [missionConfigFile >> QGVAR(settings) >> "AIMagLimit", "number", 2] call CBA_fnc_getConfigEntry;
GVAR(rainImpact) = ([missionConfigFile >> QGVAR(settings) >> "rainImpact", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(rainPercent) = [missionConfigFile >> QGVAR(settings) >> "rainPercent", "number", 3] call CBA_fnc_getConfigEntry;
GVAR(suppressionVar) = ([missionConfigFile >> QGVAR(settings) >> "suppressionVar", "number", 5] call CBA_fnc_getConfigEntry) == 1;
GVAR(adrenaline) = ([missionConfigFile >> QGVAR(settings) >> "adrenaline", "number", 0] call CBA_fnc_getConfigEntry) == 1;
GVAR(adrenalineVar) = [missionConfigFile >> QGVAR(settings) >> "adrenalineVar", "number", 1.35] call CBA_fnc_getConfigEntry;
GVAR(IRLaser) = ([missionConfigFile >> QGVAR(settings) >> "IRLaser", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(increasingAccuracy) = ([missionConfigFile >> QGVAR(settings) >> "increasingAccuracy", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(campfires) = ([missionConfigFile >> QGVAR(settings) >> "campfires", "number", 0] call CBA_fnc_getConfigEntry) == 1;
GVAR(waypointDistance) = [missionConfigFile >> QGVAR(settings) >> "waypointDistance", "number", 300] call CBA_fnc_getConfigEntry;

//Sight Settings
GVAR(SightAidFeature) = ([missionConfigFile >> QGVAR(settings) >> "SightAid" >> "feature", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(SightAidVehicles) = ([missionConfigFile >> QGVAR(settings) >> "SightAid" >> "vehicles", "number", 0] call CBA_fnc_getConfigEntry) == 1;
GVAR(SightAidDistance) = [missionConfigFile >> QGVAR(settings) >> "SightAid" >> "distance", "number", 800] call CBA_fnc_getConfigEntry;
GVAR(SightAidMinIncrease) = [missionConfigFile >> QGVAR(settings) >> "SightAid" >> "minIncrease", "number", 2] call CBA_fnc_getConfigEntry;
GVAR(SightAidEngageDistance) = [missionConfigFile >> QGVAR(settings) >> "SightAid" >> "engageDistance", "number", 200] call CBA_fnc_getConfigEntry;

//Bunker Settings
GVAR(BunkerDistance) = [missionConfigFile >> QGVAR(settings) >> "Bunker" >> "distance", "number", 1200] call CBA_fnc_getConfigEntry;
GVAR(AimDistAdjust) = [missionConfigFile >> QGVAR(settings) >> "Bunker" >> "aimDistAdjust", "number", 0.00024] call CBA_fnc_getConfigEntry;
GVAR(AimConeAdjust) = [missionConfigFile >> QGVAR(settings) >> "Bunker" >> "aimConeAdjust", "number", 0.975] call CBA_fnc_getConfigEntry;
GVAR(aimedAdjust) = [missionConfigFile >> QGVAR(settings) >> "Bunker" >> "aimedAdjust", "number", 0.999] call CBA_fnc_getConfigEntry;
GVAR(aimTargetHeightAdjust) = [missionConfigFile >> QGVAR(settings) >> "Bunker" >> "aimTargetHeightAdjust", "number", 2] call CBA_fnc_getConfigEntry;
GVAR(BunkerEnemyLOSChecks) = [missionConfigFile >> QGVAR(settings) >> "Bunker" >> "enemyLOSChecks", "number", 20] call CBA_fnc_getConfigEntry;
GVAR(BunkerRelease) = ([missionConfigFile >> QGVAR(settings) >> "Bunker" >> "release", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(BunkerReleaseDistance) = [missionConfigFile >> QGVAR(settings) >> "Bunker" >> "releaseDistance", "number", 15] call CBA_fnc_getConfigEntry;
GVAR(BunkerSightlevel) = [missionConfigFile >> QGVAR(settings) >> "Bunker" >> "sightlevel", "number", 0.15] call CBA_fnc_getConfigEntry;
GVAR(BunkerMaxBurstResetCount) = [missionConfigFile >> QGVAR(settings) >> "Bunker" >> "maxBurstResetCount", "number", 3] call CBA_fnc_getConfigEntry;

//Skill Settings
GVAR(CustomSkillEnabled) = ([missionConfigFile >> QGVAR(settings) >> "CustomSkill" >> "feature", "number", 0] call CBA_fnc_getConfigEntry) == 1;
GVAR(CustomSkill_aimingspeed) = [missionConfigFile >> QGVAR(settings) >> "CustomSkill" >> "aimingspeed", "number", 1] call CBA_fnc_getConfigEntry;
GVAR(CustomSkill_spotdistance) = [missionConfigFile >> QGVAR(settings) >> "CustomSkill" >> "spotdistance", "number", 1] call CBA_fnc_getConfigEntry;
GVAR(CustomSkill_aimingaccuracy) = [missionConfigFile >> QGVAR(settings) >> "CustomSkill" >> "aimingaccuracy", "number", 0.65] call CBA_fnc_getConfigEntry;
GVAR(CustomSkill_aimingshake) = [missionConfigFile >> QGVAR(settings) >> "CustomSkill" >> "aimingshake", "number", 0.8] call CBA_fnc_getConfigEntry;
GVAR(CustomSkill_spottime) = [missionConfigFile >> QGVAR(settings) >> "CustomSkill" >> "spottime", "number", 1] call CBA_fnc_getConfigEntry;
GVAR(CustomSkill_reloadspeed) = [missionConfigFile >> QGVAR(settings) >> "CustomSkill" >> "reloadspeed", "number", 1] call CBA_fnc_getConfigEntry;
GVAR(CustomSkill_endurance) = [missionConfigFile >> QGVAR(settings) >> "CustomSkill" >> "commanding", "number", 1] call CBA_fnc_getConfigEntry;
GVAR(CustomSkill_commanding) = [missionConfigFile >> QGVAR(settings) >> "CustomSkill" >> "endurance", "number", 1] call CBA_fnc_getConfigEntry;
GVAR(CustomSkill_general) = [missionConfigFile >> QGVAR(settings) >> "CustomSkill" >> "general", "number", 1] call CBA_fnc_getConfigEntry;
GVAR(CustomSkill_courage) = [missionConfigFile >> QGVAR(settings) >> "CustomSkill" >> "courage", "number", 1] call CBA_fnc_getConfigEntry;

GVAR(CommanderEnabled) = ([missionConfigFile >> QGVAR(settings) >> "Commander" >> "feature", "number", 0] call CBA_fnc_getConfigEntry) == 1;
GVAR(CommanderDebug) = ([missionConfigFile >> QGVAR(settings) >> "Commander" >> "feature", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(CommanderSide) = switch (tolower ([missionConfigFile >> QGVAR(settings) >> "Commander" >> "feature", "side", "east"] call CBA_fnc_getConfigEntry)) do {
    case "west": {west};
    case "east": {east};
    case "independent": {independent};
    case "civilian": {civilian};
};
GVAR(CommanderPersonality) = tolower ([missionConfigFile >> QGVAR(settings) >> "Commander" >> "personality", "string", "random"] call CBA_fnc_getConfigEntry);
GVAR(CommanderDelay) = [missionConfigFile >> QGVAR(settings) >> "Commander" >> "delay", "number", 3] call CBA_fnc_getConfigEntry;
GVAR(CommanderSkill) = [missionConfigFile >> QGVAR(settings) >> "Commander" >> "skill", "number", 3] call CBA_fnc_getConfigEntry;
GVAR(CommanderQRF) = [missionConfigFile >> QGVAR(settings) >> "qrf", "array", []] call CBA_fnc_getConfigEntry;
GVAR(CommanderQRFThreshold) = tolower ([missionConfigFile >> QGVAR(settings) >> "Commander" >> "QRFThreshold", "string", "Combat"] call CBA_fnc_getConfigEntry);
GVAR(CommanderRoam) = ([missionConfigFile >> QGVAR(settings) >> "Commander" >> "roam", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(CommanderWithdrawal) = ([missionConfigFile >> QGVAR(settings) >> "Commander" >> "withdrawal", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(CommanderArty) = [missionConfigFile >> QGVAR(settings) >> "arty", "array", []] call CBA_fnc_getConfigEntry;
GVAR(CommanderAirStrikesF) = [missionConfigFile >> QGVAR(settings) >> "airStrikes", "array", []] call CBA_fnc_getConfigEntry;
GVAR(CommanderParadrops) = [missionConfigFile >> QGVAR(settings) >> "paradrops", "array", []] call CBA_fnc_getConfigEntry;
GVAR(CommanderAssignStartZone) = ([missionConfigFile >> QGVAR(settings) >> "Commander" >> "assignStartZone", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(CommanderAreas) = [];
private _configAreas = "true" configClasses (missionConfigFile >> QGVAR(settings) >> "Commander" >> "areas");
TRACE_1("",_configAreas);
_configAreas apply {
    private _name = configName _x;
    private _marker = [_x >> "marker", "string", ""] call CBA_fnc_getConfigEntry;
    private _mission = [_x >> "mission", "string", "Patrol"] call CBA_fnc_getConfigEntry;
    private _min = [_x >> "minAssets", "number", 2] call CBA_fnc_getConfigEntry;
    private _max = [_x >> "maxAssets", "number", 2] call CBA_fnc_getConfigEntry;
    private _threshold = [_x >> "threshold", "number", 0] call CBA_fnc_getConfigEntry;
    private _qrfSupport = ([_x >> "qrfSupport", "number", 0] call CBA_fnc_getConfigEntry) == 1;
    private _assetSupport = ([_x >> "assetSupport", "number", 0] call CBA_fnc_getConfigEntry) == 1;
    private _withdrawal = ([_x >> "withdrawal", "number", 0] call CBA_fnc_getConfigEntry) == 1;
    private _resourceUse = ([_x >> "resourceUse", "number", 0] call CBA_fnc_getConfigEntry) == 1;
    private _preferedTypes = [_x >> "preferedTypes", "array", ["infantry"]] call CBA_fnc_getConfigEntry;
    private _terrainMode = [_x >> "terainMode", "string", "Auto"] call CBA_fnc_getConfigEntry;
    GVAR(CommanderAreas) pushBackUnique [
        _name,
        _marker,
        _mission,
        _min,
        _max,
        _threshold,
        _qrfSupport,
        _assetSupport,
        _withdrawal,
        _resourceUse,
        _preferedTypes,
        _terrainMode
    ];
};
TRACE_1("",GVAR(CommanderAreas));

[] call FUNC(checkifHC);

//exit clients
AI_EXEC_CHECK(HC);

[QGVAR(HCReceiveArrayDataEvent), {
    LOG_1("Received Array Data: %1",_this);
    GVAR(zoneEntities) = createHashMap;
    GVAR(zoneEntities) = _this;
    SETMVAR(receivedArrayData,true);
}] call CBA_fnc_addEventHandler;

[QGVAR(reportShotEvent), {
    params ["_firer", "_weapon", "_ammo"];
    allGroups select {
        private _leader = leader _x;
        local _leader &&
        {!isNull _leader} &&
        {alive _leader} &&
        {!isPlayer _leader} &&
        {!(GETVAR(_leader,NOAI,false))} &&
        {GETVAR(_x,Spawned,false)} &&
        {_leader distance _firer <= GVAR(HearingDistance)}
    } apply {
        private _leader = leader _x;
        private _distance = _leader distance _firer;
        private _travelTime = _distance / 343;
        private _revealValue = linearConversion [200, GVAR(HearingDistance), _distance, 4, GVAR(HearingMinIncrease)];
        [{
            params ["_firer","_groupLeader","_revealValue"];
            _groupLeader reveal [_firer, _revealValue];
            if (GETMVAR(VerboseDebug,false)) then {
                ////LOG_5("%1 got revealed to %2\n %3m, %4 seconds, %5 reveal value.",_firer,_groupLeader,_distance,_travelTime,_revealValue);
            };
        }, [_firer,_leader,_revealValue], _travelTime] call CBA_fnc_waitAndExecute;
    };
}] call CBA_fnc_addEventHandler;

[QGVAR(SpawnArrayEvent), {
    private _arrayName = "";
    private _specialArgs = [];
    if (_this isEqualType []) then {
        _arrayName = _this deleteAt 0;
        _specialArgs = _this;
    } else {
        _arrayName = _this;
    };
    private _initial = CBA_MissionTime <= 0;
    //LOG_2("SpawnArray _Array: %1 _initial: %2",_arrayName,_initial);
    private _logic = missionNamespace getVariable [_arrayName, objnull];
    if (_logic isEqualTo objnull) exitwith {
        //LOG_1("Could not find arrayName %1",_arrayName);
    };
    if !(_arrayName in GVAR(zoneEntities)) exitwith {
        //LOG_1("Could not find arrayName %1 in module setting",_arrayName);
    };
    private _entities = + GVAR(zoneEntities) getOrDefault [_arrayName, []];

    if (_entities isNotEqualTo []) then {
        //LOG_2("Spawning %1 on %2",_logic,clientowner);
        TRACE_2("spawning",_arrayName,_entities);
        [_initial, [_logic, _entities], _specialArgs] call FUNC(createZone);
    } else {
        //LOG_2("Did not find array %1 on %2",_logic,clientowner);
    };
}] call CBA_fnc_addEventHandler;

[QGVAR(StanceChangeEvent), {
    params ["_unit", "_groupStance", "_stance"];
    [_unit,_groupStance,_stance] call FUNC(setStance);
}] call CBA_fnc_addEventHandler;
