#include "script_component.hpp"

params [
    "_group"
];

units _group apply {
    private _unit = _x;
    SETVAR(_x,BUNKER,true);
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
SETVAR(_group,Task,"BUNKER");
