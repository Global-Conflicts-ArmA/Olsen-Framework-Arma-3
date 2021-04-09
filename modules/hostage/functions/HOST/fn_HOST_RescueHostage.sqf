#include "script_component.hpp"

private ["_unit", "_caller"];

_unit = _this select 0;
_caller = _this select 1;

if (_unit getVariable ["HOST_Rescued", false]) exitWith {};

if (animationState _unit find "acts_aidlpsitmstpssurwnondnon" != -1) then {

  _unit removeEventHandler ["AnimDone", _unit getVariable ["FW_EhAnimDone", 0]];
  _unit playMoveNow "Acts_AidlPsitMstpSsurWnonDnon_out";

};

[_unit] join group _caller;
