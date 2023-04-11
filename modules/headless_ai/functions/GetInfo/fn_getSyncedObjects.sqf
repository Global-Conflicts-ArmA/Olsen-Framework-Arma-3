#include "script_component.hpp"

params ["_synced"];

//LOG_1("command _synced %1",_synced);
private _uniqueSynced = _synced arrayIntersect _synced;

// Get all Synced units/objects to logic
private _groups = [];
private _emptyVehs = [];
private _objects = [];
private _vehLog = [];
private _entities = [];
if (isNil QGVAR(allSyncedEntities)) then {
    GVAR(allSyncedEntities) = _uniqueSynced;
} else {
    GVAR(allSyncedEntities) = GVAR(allSyncedEntities) + _uniqueSynced;
};
_uniqueSynced apply {
    private _obj =  _x;
    if (_obj isKindOf "Logic") then {
    } else {
        if (_obj isKindOf "Thing") then {
            _objects pushBackUnique ([_obj] call FUNC(getDetailsThing));
        } else {
            if (_obj isKindOf "Man") then {
                private _group = group _obj;
                if !(GETVAR(_group,vehCargo,false)) then {
                    private _groupldr = leader _group;
                    if (_groupldr isEqualTo _obj) then {
                        private _groupPos = getposATL _groupldr;
                        private _units = units _group;
                        private _groupArray = [str _group,[],[],[]];
                        private _gx = GETVAR(_group,multiplier,0);
                        //LOG_2("_group: %1 _gx: %2",_group,_gx);
                        private _groupPosArray = [];
                        private _groupPosNew = _groupPos;
                        if ((GETVAR(_group,createRadius,0)) > 1) then {
                            _groupPosArray = [_groupPos,0,(GETVAR(_group,createRadius,0)),(_gx * 5)] call FUNC(getRandomPositionCircle);
                            if (_groupPosArray isNotEqualTo []) then {
                                private _index = floor random (count _groupPosArray);
                                _groupPosNew = _groupPosArray select _index;
                                _groupPosArray deleteAt _index;
                            };
                        };
                        _units apply {
                            private _unit = _x;
                            private _unitpos = getPosATL _unit;
                            //LOG_2("_unit: %1 _unitpos: %2",_unit,_unitpos);
                            if (_groupldr isEqualTo _unit) then {
                                private _groupDetails = [_unit,_groupPosNew] call FUNC(getDetailsGroup);
                                (_groupArray select 1) append _groupDetails;
                            };
                            if (_groupPosNew isNotEqualTo _groupPos) then {
                                _unitpos = [_groupPosNew,_groupldr,_unit] call FUNC(getNewPos);
                                //LOG_3("GroupPos not equal to groupPosNew, getting new unit pos for: %1 OldPos: %2 NewPos: %3",_unit,(getPosATL _unit),_unitpos);
                            };
                            private _veh = vehicle _unit;
                            if (_veh isNotEqualTo _unit) then {
                                private _vehPos = getposATL _veh;
                                if (_groupPosNew isNotEqualTo _groupPos) then {
                                    _vehPos = _groupPosNew;
                                };
                                if !(_veh in _vehLog) then {
                                    _vehLog pushBackUnique _veh;
                                    (_groupArray select 3) pushBackUnique ([_veh,_vehPos] call FUNC(getDetailsVehicle));
                                };
                            } else {
                                private _unitArray = [_unit,_unitpos] call FUNC(getDetailsUnit);
                                (_groupArray select 2) pushBackUnique _unitArray;
                            };
                        };
                        private _occupy = ((_groupArray select 1) select 15);
                        private _newOccupy = [(GETVAR(_group,multiOccupy,0)),_gx] call FUNC(setMultiOccupy);
                        //LOG_2("_groupArray: %1 _newOccupy: %2",_groupArray,_newOccupy);
                        private _currentPos = ((_groupArray select 1) select 1);
                        for "_g" from 0 to _gx step 1 do {
                            if (_newOccupy isEqualTo 0 && {_gx isEqualTo 0}) then {
                                _groups pushBackUnique _groupArray;
                            } else {
                                if (_gx > 0) then {
                                    if (_groupPosArray isNotEqualTo []) then {
                                        private _index = (floor random (count _groupPosArray));
                                        _currentPos = _groupPosArray select _index;
                                        _groupPosArray deleteAt _index;
                                    };
                                };
                                if (_g < _newOccupy || _newOccupy isEqualTo 0) then {
                                    private _newgroup = +_groupArray;
                                    _newgroup set [0,format["%1_%2",(str _group),_g]];
                                    (_newgroup select 1) set [1, _currentPos];
                                    (_newgroup select 1) set [15, _occupy];
                                    {
                                        private _unit = _x;
                                        _unit params ["","","_unitPos"];
                                        _unit set [2,(_unitPos vectorAdd [-3 + random 3, -3 + random 3, 0])];
                                    } foreach (_newgroup select 2);
                                    _groups pushBack _newgroup;
                                } else {
                                    private _newgroup = +_groupArray;
                                    _newgroup set [0,format["%1_%2",(str _group),_g]];
                                    (_newgroup select 1) set [1, _currentPos];
                                    (_newgroup select 1) set [15, 0];
                                    {
                                        private _unit = _x;
                                        _unit params ["","","_unitPos"];
                                        _unit set [2,(_unitPos vectorAdd [-3 + random 3, -3 + random 3, 0])];
                                    } foreach (_newgroup select 2);
                                    _groups pushBack _newgroup;
                                };
                            };
                        };
                    };
                };
            } else {
                if (
                    _obj isKindOf "Air" ||
                    {_obj isKindOf "Ship" ||
                    {_obj isKindOf "LandVehicle" ||
                    {_obj isKindOf "StaticWeapon" ||
                    {_obj isKindOf "Static"}}}}
                ) then {
                    if (crew _obj isEqualTo []) then {
                        _emptyVehs pushBackUnique ([_obj] call FUNC(getDetailsVehicleEmpty));
                    };
                };
            };
        };
    };
};
_entities = [_groups,_emptyVehs,_objects];
//LOG_3("Deleting %1 Objects for Logic: %2 Entities: %3",count _synced,_logic,_entities);
//LOG_1("_uniqueSynced %1",_uniqueSynced);
[_uniqueSynced] call FUNC(deleteVehicles);
_entities
