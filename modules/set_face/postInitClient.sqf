#include "script_component.hpp"

GVAR(Blufor_RegularFaces) = [missionConfigFile >> QGVAR(settings) >> "blufor" >> "regular_faces", "array", []] call CBA_fnc_getConfigEntry;
GVAR(Blufor_SpecialFaces) = [missionConfigFile >> QGVAR(settings) >> "blufor" >> "special_faces", "array", []] call CBA_fnc_getConfigEntry;
GVAR(Blufor_SpecialUnits) = [missionConfigFile >> QGVAR(settings) >> "blufor" >> "special_units", "array", []] call CBA_fnc_getConfigEntry apply {
    missionNamespace getVariable [_x, objNull]
};
GVAR(Blufor_ExceptionUnits) = [missionConfigFile >> QGVAR(settings) >> "blufor" >> "exception_units", "array", []] call CBA_fnc_getConfigEntry apply {
    missionNamespace getVariable [_x, objNull]
};

GVAR(Opfor_RegularFaces) = [missionConfigFile >> QGVAR(settings) >> "opfor" >> "regular_faces", "array", []] call CBA_fnc_getConfigEntry;
GVAR(Opfor_SpecialFaces) = [missionConfigFile >> QGVAR(settings) >> "opfor" >> "special_faces", "array", []] call CBA_fnc_getConfigEntry;
GVAR(Opfor_SpecialUnits) = [missionConfigFile >> QGVAR(settings) >> "opfor" >> "special_units", "array", []] call CBA_fnc_getConfigEntry apply {
    missionNamespace getVariable [_x, objNull]
};
GVAR(Opfor_ExceptionUnits) = [missionConfigFile >> QGVAR(settings) >> "opfor" >> "exception_units", "array", []] call CBA_fnc_getConfigEntry apply {
    missionNamespace getVariable [_x, objNull]
};

GVAR(Indfor_RegularFaces) = [missionConfigFile >> QGVAR(settings) >> "indfor" >> "regular_faces", "array", []] call CBA_fnc_getConfigEntry;
GVAR(Indfor_SpecialFaces) = [missionConfigFile >> QGVAR(settings) >> "indfor" >> "special_faces", "array", []] call CBA_fnc_getConfigEntry;
GVAR(Indfor_SpecialUnits) = [missionConfigFile >> QGVAR(settings) >> "indfor" >> "special_units", "array", []] call CBA_fnc_getConfigEntry apply {
    missionNamespace getVariable [_x, objNull]
};
GVAR(Indfor_ExceptionUnits) = [missionConfigFile >> QGVAR(settings) >> "indfor" >> "exception_units", "array", []] call CBA_fnc_getConfigEntry apply {
    missionNamespace getVariable [_x, objNull]
};

GVAR(Civilian_RegularFaces) = [missionConfigFile >> QGVAR(settings) >> "civilian" >> "regular_faces", "array", []] call CBA_fnc_getConfigEntry;
GVAR(Civilian_SpecialFaces) = [missionConfigFile >> QGVAR(settings) >> "civilian" >> "special_faces", "array", []] call CBA_fnc_getConfigEntry;
GVAR(Civilian_SpecialUnits) = [missionConfigFile >> QGVAR(settings) >> "civilian" >> "special_units", "array", []] call CBA_fnc_getConfigEntry apply {
    missionNamespace getVariable [_x, objNull]
};
GVAR(Civilian_ExceptionUnits) = [missionConfigFile >> QGVAR(settings) >> "civilian" >> "exception_units", "array", []] call CBA_fnc_getConfigEntry apply {
    missionNamespace getVariable [_x, objNull]
};

if (GVAR(Blufor_RegularFaces) isNotEqualTo [] || GVAR(Blufor_SpecialFaces) isNotEqualTo []) then {
    private _bluforUnits = units blufor;
    _bluforUnits select {
        !(_x in GVAR(Blufor_ExceptionUnits))
    } apply {
        private _unit = _x;
        private _face = if (_unit in GVAR(Blufor_SpecialUnits)) then {
            selectRandom GVAR(Blufor_SpecialFaces)
        } else {
            if (GVAR(Blufor_RegularFaces) isNotEqualTo []) then {
                selectRandom GVAR(Blufor_RegularFaces)
            } else {
                ""
            };
        };
        if (_face isNotEqualTo "") then {
            [_unit, _face] remoteExec ["setFace", 0, _unit];
        };
    };
};

if (GVAR(Opfor_RegularFaces) isNotEqualTo [] || GVAR(Opfor_SpecialFaces) isNotEqualTo []) then {
    private _opforUnits = units opfor;
    _opforUnits select {
        !(_x in GVAR(Opfor_ExceptionUnits))
    } apply {
        private _unit = _x;
        private _face = if (_unit in GVAR(Opfor_SpecialUnits)) then {
            selectRandom GVAR(Opfor_SpecialFaces)
        } else {
            if (GVAR(Opfor_RegularFaces) isNotEqualTo []) then {
                selectRandom GVAR(Opfor_RegularFaces)
            } else {
                ""
            };
        };
        if (_face isNotEqualTo "") then {
            [_unit, _face] remoteExec ["setFace", 0, _unit];
        };
    };
};

if (GVAR(Indfor_RegularFaces) isNotEqualTo [] || GVAR(Indfor_SpecialFaces) isNotEqualTo []) then {
    private _indforUnits = units independent;
    _indforUnits select {
        !(_x in GVAR(Indfor_ExceptionUnits))
    } apply {
        private _unit = _x;
        private _face = if (_unit in GVAR(Indfor_SpecialUnits)) then {
            selectRandom GVAR(Indfor_SpecialFaces)
        } else {
            if (GVAR(Indfor_RegularFaces) isNotEqualTo []) then {
                selectRandom GVAR(Indfor_RegularFaces)
            } else {
                ""
            };
        };
        if (_face isNotEqualTo "") then {
            [_unit, _face] remoteExec ["setFace", 0, _unit];
        };
    };
};

if (GVAR(Civilian_RegularFaces) isNotEqualTo [] || GVAR(Civilian_SpecialFaces) isNotEqualTo []) then {
    private _civilianUnits = units civilian;
    _civilianUnits select {
        !(_x in GVAR(Civilian_ExceptionUnits))
    } apply {
        private _unit = _x;
        private _face = if (_unit in GVAR(Civilian_SpecialUnits)) then {
            selectRandom GVAR(Civilian_SpecialFaces)
        } else {
            if (GVAR(Civilian_RegularFaces) isNotEqualTo []) then {
                selectRandom GVAR(Civilian_RegularFaces)
            } else {
                ""
            };
        };
        if (_face isNotEqualTo "") then {
            [_unit, _face] remoteExec ["setFace", 0, _unit];
        };
    };
};
