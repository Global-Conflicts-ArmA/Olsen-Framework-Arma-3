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
 * _this call FW_fnc_BPKCHST_UTIL_HandleDisconnect;
 *
 * Public: Yes
 */
#include "script_component.hpp"

params ["_unit"];

if !([_unit] call FUNC(BPKCHST_Chestpack) isEqualTo "") then {
     [[_unit] call FUNC(BPKCHST_ChestpackContainer), _unit] spawn {
          params ["_container","_unit"];
          sleep 1.5;
          if !(alive _unit) then {
               deleteVehicle _container;
          };
     };
};
