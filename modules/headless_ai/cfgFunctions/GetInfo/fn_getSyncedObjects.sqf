#include "..\..\script_macros.hpp"

params [
    ["_synced", [], [[]]]
];

// Get all Synced units/objects to logic
private _groups = [];
private _emptyVehs = [];
private _objects = [];
private _vehLog = [];
private _entities = [];
_synced apply {
    private _obj =  _x;
    if (!(_obj isKindOf "Logic")) then {
        if (_obj isKindOf "Thing") then {
            _objects pushback ([_obj] call FUNC(getDetailsThing));
        };
        if (_obj isKindOf "StaticWeapon" || _obj isKindOf "Static" || _obj isKindOf "Air" || _obj isKindOf "Ship" || _obj isKindOf "LandVehicle") then {
            private _group = group ((crew _obj) select 0);
            if (isNull _group) then {
                _emptyVehs pushback ([_obj] call FUNC(getDetailsVehicleEmpty));
            };
        };
        if (_obj isKindOf "Man") then {
            private _group = group _obj;
            private _groupldr = leader _group;
            if (_groupldr isEqualTo _obj) then {
                private _groupPos = getposATL _groupldr;
                private _units = units _group;
                private _groupArray = [str _group,[],[]];
                private _gx = GETVAR(_group,multiplier,0);
                //LOG_2("_group: %1 _gx: %2",_group,_gx);
                private _groupPosArray = [];
                private _groupPosNew = _groupPos;
                if ((GETVAR(_group,createRadius,0)) > 1) then {
                    _groupPosArray = [_groupPos,0,(GETVAR(_group,createRadius,0)),(_gx*5)] call FUNC(getRandomPositionCircle);
                    if (!(_groupPosArray isEqualTo [])) then {
                        private _index = (floor random (count _groupPosArray));
                        _groupPosNew = _groupPosArray select _index;
                        _groupPosArray deleteAt _index;
                    };
                };
                {
                    private _unit = _x;
                    private _unitpos = getPosATL _unit;
                    //LOG_2("_unit: %1 _unitpos: %2",_unit,_unitpos);
                    if (!(_groupPosNew isEqualTo _groupPos)) then {
                        _unitpos = [_groupPosNew,_groupldr,_unit] call FUNC(getNewPos);
                        //LOG_3("GroupPos not equal to groupPosNew, getting new unit pos for: %1 OldPos: %2 NewPos: %3",_unit,(getPosATL _unit),_unitpos);
                    };
                    private _veh = assignedVehicle _unit;
                    if !(isNull _veh) then {
                        private _vehPos = getposATL _veh;
                        if !(_groupPosNew isEqualTo _groupPos) then {
                            _vehPos = _groupPosNew;
                        };
                        if !(_veh in _vehLog) then {
                            (_groupArray select 2) pushBack ([_veh,_vehPos] call FUNC(getDetailsVehicle));
                            _vehLog pushBack _veh;
                        };
                    };
                    if (_groupldr isEqualTo _unit) then {
                        {
                            (_groupArray select 1) pushback _x;
                        } forEach ([_unit,_groupPosNew] call FUNC(getDetailsGroup));
                    };
                    private _unitArray = [_unit,_unitpos,_veh] call FUNC(getDetailsUnit);
                    //LOG_1("_unitArray: %1",_unitArray);
                    (_groupArray select 2) pushback _unitArray;
                    //LOG_1("_groupArray select 2: %1",(_groupArray select 2));
                } foreach _units;
                private _occupy = ((_groupArray select 1) select 15);
                private _newOccupy = [(GETVAR(_group,multiOccupy,0)),_gx] call FUNC(setMultiOccupy);
                //LOG_2("_groupArray: %1 _newOccupy: %2",_groupArray,_newOccupy);
                private _currentPos = ((_groupArray select 1) select 1);
                for "_g" from 0 to _gx step 1 do {
                    if (_newOccupy isEqualTo 0 && {_gx isEqualTo 0}) then {
                        _groups pushback _groupArray;
                    } else {
                        if (_gx > 0) then {
                            if (!(_groupPosArray isEqualTo [])) then {
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
                            _groups pushback _newgroup;
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
                            _groups pushback _newgroup;
                        };
                    };
                };
            };
        };
    };
};
LOG_1("Deleting Objects for Logic: %1",_logic);
[_synced] call FUNC(deleteVehicles);
LOG_1("Deleting %1 Objects",count _synced);
_entities = [_groups,_emptyVehs,_objects];
LOG_1("return _entities %1",_entities);
_entities
