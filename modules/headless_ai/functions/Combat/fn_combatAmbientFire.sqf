#include "script_component.hpp"

params [
    "_group"
];

private _groupTarget = _group getVariable [QGVAR(ambientFireTarget), objNull];
if (_groupTarget isEqualType "") then {
    _groupTarget = missionNamespace getVariable [_groupTarget, objNull];
};
private _groupInterval = _group getVariable [QGVAR(ambientFireInterval), 5];
private _arrayTest = ["AUTOCOMBAT", "COVER", "SUPPRESSION", "AUTOTARGET", "TARGET", "FSM", "PATH", "MOVE"];
private _units = units _group;
_units apply {
    private _unit = _x;
    _unit doWatch ((getPosATL _unit) vectorAdd ((vectorDir _unit) vectorMultiply 100));
    _arrayTest apply {
        _unit disableAI _x;
    };
    dostop _unit;
    _unit forcespeed 0;
    _group setBehaviour "AWARE";
    SETVAR(_unit,ambientFire,true);
    SETVAR(_unit,NOAI,true);
    [_unit] call EFUNC(FW,untrackUnit);
    private _target = _unit getVariable [QGVAR(ambientFireTarget), objNull];
    if (_target isEqualType "") then {
        _target = missionNamespace getVariable [_target, objNull];
    };
    private _interval = _unit getVariable [QGVAR(ambientFireInterval), 0];
    if (_interval < 1) then {
        if (_groupInterval > 1) then {
            _interval = _groupInterval
        } else {
            ERROR_2("ambient interval too low, must be more than 1",_unit,_interval);
            _interval = 5;
        };
    };
    if (
        _target isEqualTo objNull &&
        {_groupTarget isNotEqualTo objNull} 
    ) then {
        _target = _groupTarget
    };
    private _type = "";
    if (primaryWeapon _unit isEqualTo "") then {
        if (secondaryWeapon _unit isNotEqualTo "") then {
            _type =  secondaryWeapon _unit;
            private _muzzles = [_type] call FUNC(getMuzzles);
            if (count _muzzles > 1) then {
            	_unit selectWeapon (_muzzles select 0);
            } else {
            	_unit selectWeapon _type;
            };
        };
    } else {
        _type = primaryWeapon _unit;
    };
    //private _magazine = 
    weaponState _unit params [
        "_weapon",
        "_muzzle",
        "_fireMode",
        "_magazine",
        "_ammoCount"
    ];
    private _chosenMuzzle = if (INVEHICLE(_unit)) then {
        []
    } else {
        [_muzzle, _fireMode]
    };
    private _dir = if (_target isEqualTo objNull) then {
        getDir _unit
    } else {
        _unit getDir _target
    };
    // we remove grenades because the AI is dumb
    if !(INVEHICLE(_unit)) then {
        private _grenades = [_unit] call FUNC(getGrenades);
        _grenades apply {
            // smokes and frags
            _x apply {
                _unit removeMagazine _x
            };
        };
    };
    private _reloadEH = [_unit, "Reloaded", {
        private _unit = _this select 0;
        if (INVEHICLE(_unit)) then {
            vehicle _unit setVehicleAmmo 1;
            //TRACE_1("reloaded vehicle ammo",_unit);
        } else {
            //TRACE_2("attempting to reload unit",_unit,_this);
            private _magClass = if (count _this > 4) then {
                (_this select 4) select 0
            } else {
                (_this select 3) select 0
            };
            vehicle _unit addMagazine _magClass;
            //TRACE_2("reloaded unit",_unit,_magClass);
        };
    }, []] call CBA_fnc_addBISEventHandler;
    [{
        params ["_argNested", "_idPFH"];
        _argNested params [
            "_unit",
            "_dir",
            "_interval",
            "_chosenMuzzle",
            "_reloadEH"
        ];
        if (!(_unit getVariable [QGVAR(ambientFire), false]) || _unit isEqualTo objNull) exitWith {
            _unit removeEventHandler ["Reloaded", _reloadEH];
            [_idPFH] call CBA_fnc_removePerFrameHandler;
        };
        if (!(INVEHICLE(_unit)) && {_chosenMuzzle isNotEqualTo []}) then {
            _unit selectWeapon (_chosenMuzzle select 0);
        };
        if (weaponState _unit select 6 isEqualTo 0) then {
            [_unit, _dir, (_interval - (random[0, _interval / 4, _interval / 2])), _chosenMuzzle] call FUNC(suppressDirection);
        };
    }, _interval, [
        _unit,
        _dir,
        _interval,
        _chosenMuzzle,
        _reloadEH
    ]] call CBA_fnc_addPerFrameHandler;
};

