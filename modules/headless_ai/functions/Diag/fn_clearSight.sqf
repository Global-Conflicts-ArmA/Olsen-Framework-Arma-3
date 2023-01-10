#include "script_component.hpp"


params [["_unit", objNull, [objNull]]];

if (_unit isEqualTo objNull) exitWith {
    ERROR_1("null unit call for clearSight",_unit);
    false
};

private _response = ((_unit nearEntities ["Man", 3]) findIf {
    [getPosATL _unit, getDir _unit, 5, getPosATL _x] call BIS_fnc_inAngleSector
}) isEqualTo -1;

_response
