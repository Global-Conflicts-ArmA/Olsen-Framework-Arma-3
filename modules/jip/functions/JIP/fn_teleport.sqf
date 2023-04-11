#include "script_component.hpp"

params ["_target"];

if !(
        (_target call EFUNC(FW,isAlive)) &&
        {
            !(INVEHICLE(_target)) ||
            {((vehicle _target) call EFUNC(FW,getEmptyPositions)) isEqualTo []}
        }
) then {
	private _rank = -1;
	private _count = 0;
    (units group player) select {
        _x call EFUNC(FW,isAlive) &&
		{_x isNotEqualTo player}
    } apply {
        _count = _count + 1;
        if ((rankId _x > _rank) && {!(INVEHICLE(_x)) || {((vehicle _x) call EFUNC(FW,getEmptyPositions) isEqualTo [])}}) then {
            _rank = rankId _x;
            _target = _x;
        };
    };
	if (_rank isEqualTo -1) then {
		_target = objNull;
        if (_count isEqualto 0) then {
            [player, 1, ["ACE_SelfActions", QGVAR(TeleportAction)]] call ace_interact_menu_fnc_removeActionFromObject;
            ["No one left in the squad, cannot teleport!"] call EFUNC(FW,parsedTextDisplay);
        } else {
            ["Not possible to JIP teleport to anyone, please try again later"] call EFUNC(FW,parsedTextDisplay);
        };
	};
};

if (_target isNotEqualTo objnull) then {
    ["ace_common_displayTextStructured", [["%1 joined the mission and is teleporting to you in 5 seconds", name player], 1.5, _target], [_target]] call CBA_fnc_targetEvent;
    [player, 1, ["ACE_SelfActions", QGVAR(TeleportAction)]] call ace_interact_menu_fnc_removeActionFromObject;
    ["Teleporting in 5 seconds..."] call EFUNC(FW,parsedTextDisplay);
    [{
        params ["_target"];
        if (INVEHICLE(_target)) then {
    		player moveInAny (vehicle _target);
            ["ace_common_displayTextStructured", [["%1 has teleported into your vehicle", name player], 1.5, _target], [_target]] call CBA_fnc_targetEvent;
    	} else {
            private _stance = stance _target;
            private _animName = switch (_stance) do {
            	case "CROUCH": {"PlayerCrouch"};
            	case "PRONE": {"PlayerProne"};
                default {"PlayerStand"};
            };
            player playAction _animName;
            private _pos = [(_target getpos [-2, getdir _target]), 1, 10, 1, 0, 25, 0] call BIS_fnc_findSafePos;
    		player setPosATL _pos;
            ["ace_common_displayTextStructured", [["%1 has teleported to you", name player], 1.5, _target], [_target]] call CBA_fnc_targetEvent;
    	};
    }, _target, 5] call CBA_fnc_waitAndExecute;
} else {
    ["Something went wrong, target doesn't exist."] call EFUNC(FW,parsedTextDisplay);
};
