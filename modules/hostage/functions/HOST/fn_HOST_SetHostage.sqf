#include "script_component.hpp"

private "_unit";

_unit = _this select 0;

if (hasInterface) then {
  _unit addAction ["<t color='#FBB829'>Rescue Hostage</t>",{
    [-2,{_this call FUNC(HOST_RescueHostage);},[_this select 0, _this select 1]] call CBA_fnc_globalExecute;
  }, nil, 6, true, true, "", "(_target distance _this) < 2 && !(_target getVariable ['HOST_Rescued', false]);"];
};

if (!isServer) exitWith {};

_this spawn {
  private ["_EhAnimDone", "_unit", "_marker", "_break"];

  _unit = _this select 0;
  _marker = _this select 1;

  waitUntil {time > 0.1};
  /* [{time > 0.1}, { */
    _unit setBehaviour "CARELESS";
    _unit allowFleeing 0;
    _unit setCaptive true;

    _unit playMoveNow "Acts_AidlPsitMstpSsurWnonDnon04";

    _EhAnimDone = _unit addEventHandler ["AnimDone", {
        private "_unit";
        _unit = _this select 0;

        if (!alive _unit) exitWith {
          _unit removeEventHandler ["AnimDone", _unit getVariable ["FW_EhAnimDone", 0]];
        };

        _unit playMoveNow "Acts_AidlPsitMstpSsurWnonDnon04";
      }
    ];

    _unit setVariable ["FW_EhAnimDone", _EhAnimDone];

    _break = false;

    while {true} do {
    /* [{
      params ["_args", "_idPFH"]; */

      if (animationState _unit != "acts_aidlpsitmstpssurwnondnon04" && _unit inArea  _marker) then {

        _unit setVariable ["HOST_Rescued", true, true];

        if (vehicle _unit == _unit) exitWith {

          [_unit] joinSilent grpNull;
          _unit disableAI "MOVE";

          [{
            _unit playMoveNow "AmovPsitMstpSnonWnonDnon_ground";
            _break = true;

            /* [_idPFH] call CBA_fnc_removePerFrameHandler; */
          }, [], 1] call CBA_fnc_waitAndExecute;
        };
      };

      if (_break) exitWith {};

      sleep 15;
      /* } , 15, []] call CBA_fnc_addPerFrameHandler; */
    };
  /* }, []] call CBA_fnc_waitUntilAndExecute; */
};
