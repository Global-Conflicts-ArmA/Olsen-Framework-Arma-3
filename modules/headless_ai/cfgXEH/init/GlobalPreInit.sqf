#include "..\..\script_macros.hpp"

LOG("HC Global Pre Init");

#include "..\..\settings.sqf"

[] call FUNC(checkifHC);

//exit clients
AI_EXEC_CHECK(SERVERHC);

GVAR(zoneEntities) = [];

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
        {side _leader in GVAR(SideBasedExecution)} &&
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
                LOG_5("%1 got revealed to %2\n %3m, %4 seconds, %5 reveal value.",_firer,_groupLeader,_distance,_travelTime,_revealValue);
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
    LOG_2("SpawnArray _Array: %1 _initial: %2",_arrayName,_initial);
    private _logic = missionNamespace getVariable [_arrayName, objnull];
    if (_logic isEqualTo objnull) exitwith {
        LOG_1("Could not find arrayName %1",_arrayName);
    };
    private _entities = (([_arrayName, GVAR(zoneEntities)] call FUNC(getDetails)) select 1);
    LOG_2("SpawnArray _Array: %1 _entities: %2",_arrayName,_entities);

    if !(_entities isEqualTo []) then {
        LOG_2("Spawning %1 on %2",_logic,clientowner);
        [_initial, [_logic, _entities], _specialArgs] call FUNC(createZone);
    } else {
        LOG_2("Did not find array %1 on %2",_logic,clientowner);
    };
}] call CBA_fnc_addEventHandler;

[QGVAR(StanceChangeEvent), {
    params ["_unit", "_groupStance", "_stance"];
    [_unit,_groupStance,_stance] call FUNC(setStance);
}] call CBA_fnc_addEventHandler;
