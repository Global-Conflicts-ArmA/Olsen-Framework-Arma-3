#include "script_component.hpp"

if (!(hasinterface) || {is3DEN}) exitwith {};

//contains _AOMarkers array
#include "..\..\settings.sqf"

//initial marker array define
GVAR(map_cover) = [];
GVAR(map_currentAO) = "";

//IGNORE_PRIVATE_WARNING ["_AOMarkers"];

[{!(getMarkerColor (_this select 0 select 0 select 0) isEqualTo "")},{
    //make all AOmarkers invisible
    params ["_AOMarkers"];
    private _firstMarker = _AOMarkers select 0;
    _firstMarker params ["_marker", ["_centered", true, [true]], ["_zoomlevel", 0.4, [0]]];
    {
        (_x select 0) setMarkerAlphaLocal 0;
    } forEach _AOMarkers;

    //briefing map cover and center
    _firstMarker call FUNC(CM_bordersToMap);
    if (_centered) then {
        ((uiNamespace getVariable "RscDiary") displayCtrl 51) ctrlMapAnimAdd [0, _zoomlevel, getMarkerPos _marker];
        ctrlMapAnimCommit ((uiNamespace getVariable "RscDiary") displayCtrl 51);
    };
    if (count _AOMarkers > 1) then {
    	//Add self interact option on map to switch AOs
    	private _MapChangeMenu = ["MapChangeMenu", "Switch Map", "", {}, {true}] call ace_interact_menu_fnc_createAction;
    	[player, 1, ["ACE_SelfActions", "ACE_Equipment"], _MapChangeMenu] call ace_interact_menu_fnc_addActionToObject;
    	{
    		_x params [["_marker", "", [""]], ["_centered", false, [false]], ["_zoomLevel", 0.6, [0.6]], ["_mapName", "NONE", [""]]];
    		private _text = "Switch Map to " + _mapName;
    		private _MapChangeAction = ["switch_MapAO", _text, "", {
                (_this select 2) call FUNC(CM_Live);
            },{
                visibleMap && 
                {
                    !(GVAR(map_currentAO) isEqualTo (_this select 2 select 0))
                } && 
                {(player getvariable ["HasAltMaps",false])}
            }, {}, [_marker, _centered, _zoomLevel, _mapName]] call ace_interact_menu_fnc_createAction;
    		[player, 1, ["ACE_SelfActions", "ACE_Equipment", "MapChangeMenu"], _MapChangeAction] call ace_interact_menu_fnc_addActionToObject;
    	} forEach _AOMarkers;
    };
    
    [{visibleMap},{
        params ["_marker", ["_centered", true, [true]], ["_zoomlevel", 0.4, [0]]];
        if (_centered) then {
            MapAnimAdd [0, _zoomlevel, getMarkerPos _marker];
            MapAnimCommit;
        };
    }, _AOMarkers select 0] call CBA_fnc_waitUntilAndExecute;
}, [_AOMarkers]] call CBA_fnc_waitUntilAndExecute;

