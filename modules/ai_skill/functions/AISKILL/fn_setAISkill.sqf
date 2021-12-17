#include "script_component.hpp"

private _aiskillstrings = [
          "aimingspeed",
          "spotdistance",
          "aimingaccuracy",
          "aimingshake",
          "spottime",
          "reloadspeed",
          "commanding",
          "general",
          "courage"];

if(count _this < 2) then
{
  private _temp = format ["AI skill module:<br></br>Array in file ""modules\ai_skill\settings.sqf"" is wrong."];
  _temp call EFUNC(FW,DebugMessage);
}
else
{
  params["_aiSkill", "_value"];
  private _conditions = _this;

  if(count _this == 2) then
  {
    _conditions = [["True"]];
  }
  else
  {
    private _deletefirsttwo = [_aiskill,_value];
    _conditions = _conditions - _deletefirsttwo;
  };

  private _isstringcorrect = false;
  _aiskillstrings apply {
    if(_aiskill ==_x) then
    {
      _isstringcorrect = true;
    };
  };

  if(_isstringcorrect && _value > 0.2 && _value <= 1) then
  {
    allUnits apply {
      private _conditionCheck = [];
      private _condition = false;
      private _unit = _x;
      _conditions apply {
        switch(_x select 0) do
        {
          case "Distance":
          {
            if(_unit distance (_x select 2) <= (_x select 1)) then
            {
              _condition = true;
              _conditionCheck set [count _conditionCheck,true];
            }
            else
            {
              _conditionCheck set [count _conditionCheck,false];
            };
          };
          case "Side":
          {
            if(side _unit == (_x select 1)) then
            {
              _condition = true;
              _conditionCheck set [count _conditionCheck,true];
            }
            else
            {
              _conditionCheck set [count _conditionCheck,false];
            };
          };
          case "True":
          {
            _condition = true;
            _conditionCheck set [count _conditionCheck,true];
          };
          case "Group":
          {
            if(group _unit == _x select 1) then
            {
              _condition = true;
              _conditionCheck set [count _conditionCheck,true];
            }
            else
            {
              _conditionCheck set [count _conditionCheck,false];
            };
          };
          case "Vehicle":
          {
            if(count _x == 1) then
            {
              if(INVEHICLE(_unit)) then
              {
                _condition = true;
                _conditionCheck set [count _conditionCheck,true];
              }
              else
              {
                _conditionCheck set [count _conditionCheck,false];
              };
            }
            else
            {
              if(vehicle _unit in (_x select 1)) then
              {
                _condition = true;
                _conditionCheck set [count _conditionCheck,true];
              }
              else
              {
                _conditionCheck set [count _conditionCheck,false];
              };
            }
          };
          default
          {
            _conditionCheck set [count _conditionCheck,false];
          };
        };
      };
      _conditionCheck apply {
        if(!(_x)) then
        {
          _condition = false;
        };
      };

      if(!(isPlayer _x) && _condition) then
      {
        _x setSkill [_aiskill , _value];
      };
    };

  }
  else
  {
    if(_value < 0.2 || _value > 1) then
    {
      private _temp = format ["AI skill module:<br></br>Warning AI-Skill-Value ""%1"", in file ""modules\ai_skill\settings.sqf"" , is wrong.", _value];
      _temp call EFUNC(FW,DebugMessage);
    };
    if(!(_isstringcorrect)) then
    {
      private _temp = format ["AI skill module:<br></br>Warning AI-skillstring ""%1"", in file ""modules\ai_skill\settings.sqf"" , does not exist.", _aiskill];
      _temp call FNC_DebugMessage;
    };
  };
};
