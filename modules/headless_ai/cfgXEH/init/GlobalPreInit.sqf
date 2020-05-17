#include "..\..\script_macros.hpp"

LOG("HC Global Pre Init");

#include "..\..\settings.sqf"

[] call FUNC(checkifHC);

//exit clients
AI_EXEC_CHECK(SERVERHC);

GVAR(zoneEntities) = [];

[QGVAR(PlayerShotEvent), {
    params ["_firer", "_weapon", "_ammo"];
    allUnits select {
        (!isplayer _x)
        && {(local _x)}
        && {(_x distance _firer <= GVAR(HEARINGDISTANCE))}
    } apply {
        private _distance = _x distance _firer;
        private _travelTime = _distance / 343;
        private _revealValue = linearConversion [200,GVAR(HEARINGDISTANCE),_distance,4,GVAR(HEARINGMININCREASE)];
        [{
            params ["_firer","_AIunit","_revealValue"];
            _AIunit reveal [_firer,_revealValue];
            if (GETMVAR(UseMarkers,false)) then {
                LOG_5("%1 got revealed to %2\n %3m, %4 seconds, %5 reveal value.",_firer,_x,_distance,_travelTime,_revealValue);
            };
        }, [_firer,_x,_revealValue], _travelTime] call CBA_fnc_waitAndExecute;
    };
}] call CBA_fnc_addEventHandler;

[QGVAR(SpawnArrayEvent), {
    params [["_arrayName", "", [""]]];
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
        [_initial, [_logic, _entities]] call FUNC(createZone);
    } else {
        LOG_2("Did not find array %1 on %2",_logic,clientowner);
    };
}] call CBA_fnc_addEventHandler;

[QGVAR(StanceChangeEvent), {
    params ["_unit", "_groupStance", "_stance"];
    [_unit,_groupStance,_stance] call FUNC(setStance);
}] call CBA_fnc_addEventHandler;

/*
["CAManBase", "FiredMan", {
    params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle"];
    private _ammoLeft = ((weaponState _unit) select 4);
    //LOG_5("FiredMan EH called for %1 ammoLeft: %2 _weapon: %3 primaryWeapon: %4 speed: %5",_unit,_ammoLeft,_weapon,(primaryWeapon _unit),(speed (vehicle _unit)));
    if (
        (local _unit) 
        && {!isPlayer _unit} 
        && {vehicle _unit isEqualTo _unit} 
        && {behaviour _unit in ["COMBAT","STEALTH"]} 
        && {!(stance _unit isEqualTo "PRONE")}
        && {_weapon isEqualTo primaryWeapon _unit} 
        && {_ammoLeft isEqualTo 0} 
        && {speed (vehicle _unit) <= 2}
    ) then {
        private _stance = stance _unit;
        private _testHeight = -1;
        private _newStance = "MIDDLE";
        switch (_stance) do {
            case "STAND": {
                _newStance = "MIDDLE";
                _testHeight = 1;
            };
            case "CROUCH": {
                _newStance = "DOWN";
                _testHeight = 0.22;
            };
            default {};
        };
        LOG_3("FiredMan EH past check for %1 with _stance %2 and _testHeight: %3",_unit, _stance, _testHeight);
        if ((_testHeight > 0) && {!([_unit, getDir _unit, _testHeight] call FUNC(checkView))}) then {
            doStop _unit;
            _unit setUnitPos _newStance;
            SETVAR(_unit,reloading,true);
            SETVAR(_unit,reloadingStance,_stance);
            LOG_2("FiredMan EH set stance for %1 with %2",_unit, _newStance);
        };
    };
}] call CBA_fnc_addClassEventHandler;

["CAManBase", "Reloaded", {
    params ["_unit", "_weapon", "_muzzle", "_newMagazine", "_oldMagazine"];
    if (
        (local _unit)
        && {!isPlayer _unit}
        && {vehicle _unit isEqualTo _unit}
        && {behaviour _unit in ["COMBAT","STEALTH"]} 
        && {stance _unit in ["PRONE","CROUCH"]}
        && {!([_unit,getDir _unit] call FUNC(checkView))}
    ) then {
        SETVAR(_unit,reloading,false);
        private _reloadStance = GETVAR(_unit,reloadingStance,"STAND");
        TRACE_2("Reloaded EH set stance",_unit, _reloadStance);
        if ((_reloadStance isEqualTo "STAND") && {stance _unit isEqualTo "CROUCH"}) then {
            private _ammoCount = ((weaponState _unit) select 4);
            private _magazines = magazinesAmmoFull _unit;
            {
                _x params ["_className", "_ammoInMag", "_loaded", "", "_location"];
                _x removeMagazine _className;
            } foreach _magazines;
            _unit setAmmo [currentweapon _unit, 0];
            _unit setUnitPos "UP";
            TRACE_2("Reloaded EH STAND",_unit, _ammoCount);
            [{
                ((stance (_this select 0)) == "STAND")
                && {([(_this select 0), (getDir (_this select 0))] call FUNC(checkView))}
            }, {
                params ["_unit", "_reloadStance", "_magazines", "_ammoCount"];
                TRACE_2("Reloaded EH gave back ammo",_unit, _magazines);
                _unit setAmmo [currentweapon _unit, _ammoCount];
                {
                    _x params ["_className", "_ammoInMag", "_loaded", "", "_location"];
                    _unit addMagazine [_className, _ammoInMag];
                } foreach _magazines;
            }, [_unit, _reloadStance, _magazines, _ammoCount]] call CBA_fnc_WaitUntilAndExecute;
        } else {
            if ((_reloadStance isEqualTo "CROUCH") && {stance _unit isEqualTo "PRONE"}) then {
                private _ammoCount = ((weaponState _unit) select 4);
                private _magazines = magazinesAmmoFull _unit;
                {
                    _x params ["_className", "_ammoInMag", "_loaded", "", "_location"];
                    _unit removeMagazine _className;
                } foreach _magazines;
                _unit setAmmo [currentweapon _unit, 0];
                _unit setUnitPos "MIDDLE";
                TRACE_2("Reloaded EH MIDDLE",_unit, _ammoCount);
                [{
                    ((stance (_this select 0)) == "CROUCH")
                    && {([(_this select 0), (getDir (_this select 0))] call FUNC(checkView))}
                }, {
                    params ["_unit", "_reloadStance", "_magazines", "_ammoCount"];
                    TRACE_2("Reloaded EH gave back ammo",_unit, _magazines);
                    _unit setAmmo [currentweapon _unit, _ammoCount];
                    {
                        _x params ["_className", "_ammoInMag", "_loaded", "", "_location"];
                        _unit addMagazine [_className, _ammoInMag];
                    } foreach _magazines;
                }, [_unit, _reloadStance, _magazines, _ammoCount]] call CBA_fnc_WaitUntilAndExecute;
            };
        };
    };
}] call CBA_fnc_addClassEventHandler;
*/
