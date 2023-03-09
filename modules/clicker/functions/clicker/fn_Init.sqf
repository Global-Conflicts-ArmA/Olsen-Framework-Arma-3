#include "script_component.hpp"

#include "..\..\settings.sqf"

[{(!isNull ace_player) && {(findDisplay 46) isNotEqualTo displayNull}}, {
    SETVAR(ace_player,lastClickerTime,CBA_MissionTime);
    private _nvEH = (findDisplay 46) displayAddEventHandler ["keyDown", {
        private _key = _this select 1;
        if (
            _key in (actionKeys (GETMVAR(actionKey,"nightVision"))) &&
            {CBA_MissionTime >= (GETVAR(ace_player,lastClickerTime,(CBA_MissionTime - 0.4))) + 0.4}
        ) exitWith {
            private _file = selectRandom (GETMVAR(soundArray,ARR_1("cricket1.ogg")));
            playSound3D [getMissionPath ("modules\clicker\sounds\" + _file), ace_player, false, getPosASL ace_player, GETMVAR(volume,1), 1, 0];
            SETVAR(ace_player,lastClickerTime,CBA_MissionTime);
            true
        };
        false
    }];

    [{!alive ace_player || ace_player getVariable [QEGVAR(FW,Spectating), false]}, {
        LOG("removed nightVision EH");
        (findDisplay 46) displayRemoveEventHandler ["keyDown", _this];
    }, _nvEH] call CBA_fnc_waitUntilAndExecute;
}] call CBA_fnc_waitUntilAndExecute;
