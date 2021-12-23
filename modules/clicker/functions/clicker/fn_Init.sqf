#include "script_component.hpp"

[{(!isNull ace_player) && {(findDisplay 46) isNotEqualTo displayNull}}, {
    ace_player setVariable [QGVAR(lastClickerTime), CBA_MissionTime];
    private _nvEH = (findDisplay 46) displayAddEventHandler ["keyDown", {
        private _key = _this select 1;
        if (_key in actionKeys "nightVision" && {(CBA_MissionTime >= ((ace_player getVariable [QGVAR(lastClickerTime), CBA_MissionTime - 1]) + 1))}) exitWith {
            playSound3D [getMissionPath "modules\clicker\sounds\cricket.ogg", player, false, getPosASL player, 1, 1, 0];
            ace_player setVariable [QGVAR(lastClickerTime), CBA_MissionTime];
            true
        };
        false
    }];
    
    [{!alive ace_player || ace_player getVariable [QEGVAR(FW,Spectating), false]}, {
        LOG("removed nightVision EH");
        (findDisplay 46) displayRemoveEventHandler ["keyDown", _this];
    }, _nvEH] call CBA_fnc_waitUntilAndExecute;
}] call CBA_fnc_waitUntilAndExecute;


