#include "script_component.hpp"

private _version = 0.1;

["Call Mission", "Adds a new sections to the framework menu that allows COs and admins to call the mission.", "Starfox64 &amp; StatusRed", _version] call EFUNC(FW,RegisterModule);

GVAR(IsAdmin) = false;
GVAR(MissionCalls) = [];

#include "settings.sqf"

private _waitTime = 60;
[{
	private _cocParams = [
	    [west, GVAR(COC_West)], 
	    [east, GVAR(COC_East)],
	    [independent, GVAR(COC_Indfor)],
	    [civilian, GVAR(COC_Civ)]
	];
	_cocParams apply {
	    _x params ["_side", "_coc"];
	    private _found = false;
	    _coc apply {
	        private _groupID = _x;
	        if (_found) exitWith {};
	        allGroups select {(side leader _x) isEqualTo _side} apply {
	            private _group = _x;
	            if (groupID _group isEqualTo _groupID) exitWith {
	                if !((leader _group) getVariable ["FW_isCO", false]) then {
	                    (leader _group) setVariable ["FW_isCO", true];
	                    playableUnits select {(side _x) isEqualTo (side leader _group) && {_x isNotEqualTo (leader _group)}} apply {
	                        _x setVariable ["FW_isCO", false];
	                    };
	                };
	                _found = true;
	            };
	        };
	    };
	};
} , _waitTime, []] call CBA_fnc_addPerFrameHandler;

[{!isNull (findDisplay 46)}, {
    // serverCommandAvailable must be executed from a UI Eh.
    (findDisplay 46) displayAddEventHandler ["MouseMoving", {
        GVAR(IsAdmin) = serverCommandAvailable "#kick"
    }];
}, []] call CBA_fnc_waitUntilAndExecute;

// Admin Call Options
["AdminBLUFOR", sideUnknown, "Call Mission BLUFOR Victory", [[west, "AdminCalled", true], [east, "AdminCalled", false], [independent, "AdminCalled", false], [civilian, "AdminCalled", false]]] call FUNC(RegisterMissionCall);
["AdminOPFOR", sideUnknown, "Call Mission OPFOR Victory", [[west, "AdminCalled", false], [east, "AdminCalled", true], [independent, "AdminCalled", false], [civilian, "AdminCalled", false]]] call FUNC(RegisterMissionCall);
["AdminINDFOR", sideUnknown, "Call Mission INDFOR Victory", [[west, "AdminCalled", false], [east, "AdminCalled", false], [independent, "AdminCalled", true], [civilian, "AdminCalled", false]]] call FUNC(RegisterMissionCall);
["AdminCIVFOR", sideUnknown, "Call Mission CIVFOR Victory", [[west, "AdminCalled", false], [east, "AdminCalled", false], [independent, "AdminCalled", false], [civilian, "AdminCalled", true]]] call FUNC(RegisterMissionCall);

