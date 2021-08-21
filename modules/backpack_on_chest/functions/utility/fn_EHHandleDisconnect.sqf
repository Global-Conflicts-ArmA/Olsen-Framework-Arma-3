/*
 * Author: DerZade
 * Triggerd by HandleDisconnect-Eventhandler on Server.
 * Handles deleting the chestpack of old units form disconnected players.
 *
 * Arguments:
 * 0: unit <OBJECT>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * _this call zade_boc_fnc_HandleDisconnect;
 *
 * Public: Yes
 */
params ["_unit"];

if !([_unit] call zade_boc_fnc_chestpack isEqualTo "") then {
     [[_unit] call zade_boc_fnc_chestpackContainer, _unit] spawn {
          params ["_container","_unit"];
          sleep 1.5;
          if !(alive _unit) then {
               deleteVehicle _container;
          };
     };
};
