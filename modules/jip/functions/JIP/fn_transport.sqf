#include "script_component.hpp"

private _transporterList = GETMVAR(teamTransporters,[]);
if (_transporterList isNotEqualTo [] && {(_transporterList select {_x call EFUNC(FW,isAlive)}) isNotEqualTo []}) then {
    ["ace_common_displayTextStructured", [["%1 joined the mission and is requesting transport", name player], 1.5, (GETMVAR(teamTransporters,[]))], [(GETMVAR(teamTransporters,[]))]] call CBA_fnc_targetEvent;
    ["Transporters have been notified"] call EFUNC(FW,parsedTextDisplay);
} else {
    private _CO = [side player] call EFUNC(FW,getCO);
    ["ace_common_displayTextStructured", [["%1 joined the mission and is requesting transport", name player], 1.5, _CO], [_CO]] call CBA_fnc_targetEvent;
    ["CO has been notified"] call EFUNC(FW,parsedTextDisplay);
};

[player, 1, ["ACE_SelfActions", QGVAR(TransportAction)]] call ace_interact_menu_fnc_removeActionFromObject;
