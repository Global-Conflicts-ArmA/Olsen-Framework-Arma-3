#include "script_component.hpp"

if (isNil "AILINK_aiLink_debug") then {GVAR(aiLink_debug) = false};
if (GVAR(aiLink_transDelay) > GVAR(aiLink_shareDelay)) then {GVAR(aiLink_transDelay) = GVAR(aiLink_shareDelay)};

private _allLinkGroups = [];
allGroups apply {	//Remove player controlled groups
  if !(isPlayer (leader _x)) then {
    _allLinkGroups set [count _allLinkGroups,_x];
  };
};

if (GVAR(aiLink_debug)) then {diag_log format["Link Groups: %1",_allLinkGroups];};

private _groups = [];

_allLinkGroups apply {	//Share that sweet, sweet info
  private _thisGroup = _x;
  private _thisLR = nil;
  private _thisSR = nil;
  private _thatLR = nil;
  private _thatSR = nil;

  _groups = _groups - [_thisGroup];
  _groups apply {
    private _thatGroup = _x;
    if (side _thisGroup == side _thatGroup) then {
      if (GVAR(aiLink_needRadio)) then {
        private _thisArray = [_thisGroup] call FUNC(evalRadio);
        private _thatArray = [_thatGroup] call FUNC(evalRadio);

        _thisLR = _thisArray select 0;
        _thisSR = _thisArray select 1;
        _thatLR = _thatArray select 0;
        _thatSR = _thatArray select 1;
      } else {
        _thisLR = true;
        _thisSR = true;
        _thatLR = true;
        _thatSR = true;
      };

      private _range = 25;
      if (_thisLR && _thatLR) then {
        _range = GVAR(aiLink_longRange);
      } else {
        if (_thisSR && _thatSR) then {
          _range = GVAR(aiLink_shortRange)
        };
      };

      private _checkUnits = allUnits;
      if (isMultiplayer) then {_checkUnits = playableUnits};
      _checkUnits apply {
        if (_thisGroup knowsAbout _x > _thatGroup knowsAbout _x && _thisGroup knowsAbout _x > 1 && _thatGroup knowsAbout _x < 1.5 && (leader _thisGroup distance2D _x) <= _range) then {
          private _waitTime = random(GVAR(aiLink_transDelay));
          [{
            params ["_thatGroup","_thisGroup","_targUnit"];
            private _revAmt = _thisGroup knowsAbout _targUnit;
            if (_revAmt > GVAR(aiLink_maxKnows)) then {_revAmt = GVAR(aiLink_maxKnows)};
            if (_revAmt > _thatGroup knowsAbout _targUnit) then {_thatGroup reveal [_targUnit,_revAmt];};

            if (GVAR(aiLink_debug)) then {diag_log format["Update || This: %1 | That: %2 | Targ: %3 | Knows:%4",_thisGroup,_thatGroup,_targUnit,_revAmt];};
          }, [_thatGroup,_thisGroup,_x],_waitTime] call CBA_fnc_waitAndExecute;
          if (GVAR(aiLink_debug)) then {diag_log format["Pre-update || This: %1 | That: %2 | Targ: %3",_thisGroup,_thatGroup,_x];};
        };
        if (GVAR(aiLink_debug)) then {diag_log format["Check || This: %1 | That: %2 | Targ: %3",_thisGroup knowsAbout _x,_thatGroup knowsAbout _x,_x];};
      };

      if (GVAR(aiLink_debug)) then {diag_log format["Rem Groups: %1 | This: %2 | That:%3 | ThisLR:%4 | ThatLR:%5 | Range:%6",_groups,_thisGroup,_thatGroup,_thisLR,_thatLR,_range];};
    };
  };
  _groups = _allLinkGroups;
};

[{call FUNC(aiLink)},[],GVAR(aiLink_shareDelay)] call CBA_fnc_waitAndExecute;
