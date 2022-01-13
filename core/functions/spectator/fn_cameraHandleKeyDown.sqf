/*
	Author: Karel Moricky

	Description:
	Splendid config viewer

	Parameter(s):
	_this select 0: STRING - Parent display (when you need to run the viewer from editor)

	Returns:
	NOTHING
*/


#define DIK_SPACE 0x39
#define DIK_APOSTROPHE 0x28
#define DIK_F1 0x3B
#define DIK_ESCAPE 0x01

#include "script_component.hpp"

disableserialization;

private _key = _this select 1;

if (isMultiplayer && {!([] call CBA_fnc_isDebugConsoleAllowed)}) then {
    if (_key in [DIK_F1, DIK_SPACE]) exitWith {
        true
    };
};

if (_key in [DIK_APOSTROPHE, DIK_ESCAPE]) exitWith {
    private _dir = positionCameraToWorld [0,0,0] getdir positionCameraToWorld [0,0,1];
    private _vectorDir = (agltoasl positionCameraToWorld [0,0,0]) vectorFromTo (agltoasl positionCameraToWorld [0,0,1]);
    _vectorDir = [_vectorDir,_dir] call BIS_fnc_rotateVector2D;
    private _vectorDirY = _vectorDir select 1;
    if (_vectorDirY == 0) then {_vectorDirY = 0.01;};
    private _pitch = atan ((_vectorDir select 2) / _vectorDirY);
    private _pos = positionCameraToWorld [0,0,0];
    private _pitchDir = [_pitch, _dir, _pos];
    (finddisplay 314) closedisplay 2;
    [{
        (finddisplay 314) isEqualTo displayNull
    },{
        params ["_pitchDir"];
        [{
            params ["_pitchDir"];
            private _initialized = ["Initialize",
                [
                    player,
                    GVAR(eg_Whitelisted_Sides),
                    GVAR(eg_Ai_Viewed_By_Spectator),
                    GVAR(eg_Free_Camera_Mode_Available),
                    GVAR(eg_Third_Person_Perspective_Camera_mode_Available),
                    GVAR(eg_Show_Focus_Info_Widget),
                    GVAR(eg_Show_Camera_Buttons_Widget),
                    GVAR(eg_Show_Controls_Helper_Widget),
                    GVAR(eg_Show_Header_Widget),
                    GVAR(eg_Show_Entities_And_Locations_Lists)
                ]
            ] call BIS_fnc_EGSpectator;
            [{
                _this select 0
            },{
                params ["", "_pitchDir"];
                _pitchDir params ["_pitch", "_dir", "_pos"];
                private _cam = ["GetCamera"] call BIS_fnc_EGSpectator;
                _cam setPosATL _pos;
                _cam setdir _dir;
        		[_cam, _pitch, 0] call bis_fnc_setpitchbank;
            }, [_initialized, _pitchDir]] call CBA_fnc_waitUntilAndExecute;
        }, [_pitchDir]] call CBA_fnc_execNextFrame;
    }, [_pitchDir]] call CBA_fnc_waitUntilAndExecute;
    true
};

with (uinamespace) do {
    ["KeyDown", _this] call BIS_fnc_Camera;
};
