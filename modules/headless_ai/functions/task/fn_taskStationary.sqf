#include "script_component.hpp"


params [
    "_group",
    "_pos",
    ["_radius",30,[0]],
    ["_wait",3,[0]],
    ["_behaviour","SAFE",[""]],
    ["_combat","RED",[""]],
    ["_speed","LIMITED",[""]],
    ["_formation","WEDGE",[""]],
    ["_Type","MOVE",[""]],
    ["_oncomplete","",[""]],
    ["_compradius",0,[0]],
    ["_wpcount",10,[0]]
];

_group setBehaviour _behaviour;
_group setCombatMode _combat;
_group setSpeedMode _speed;
_group setFormation _formation;
private _units = units _group;
_units apply {
    private _unit = _x;
    _unit doWatch ((getPosATL _unit) vectorAdd((vectorDir _unit) vectorMultiply 100));
    _unit disableAI "PATH";
    SETVAR(_unit,stationary,true);
    if (insideBuilding _unit > 0.5) then {
        private _buildings = nearestObjects [_unit, ["House", "Building"], 50];
        if (_buildings isNotEqualTo []) then {
            private _bPos = (_buildings select 0) buildingPos -1;
            private _index = _bPos findIf {
                _unit distance _x <= 2
            };
            if (_index isNotEqualTo -1) then {
                GVAR(OccupiedPositions) pushBackUnique (_bPos select _index);
            };
        };
    };
};

SETVAR(_group,Task,"STATIONARY");
