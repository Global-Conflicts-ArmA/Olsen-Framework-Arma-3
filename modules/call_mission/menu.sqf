#include "script_component.hpp"

private _html = "
<font size='18'>Calling a Mission</font><br/>
From this menu, you can call the current mission if you are the server admin or an active CO.<br/>
Be careful, it only takes one click to end the mission!<br/>
<br/>
";

private _option = [];

if (({(_x select 1) == side player} count GVAR(MissionCalls)) > 0) then {

	_html = _html + "<font size='18'>Call Mission Options</font><br/>";

	for "_i" from 0 to count GVAR(MissionCalls) -1 do {

		_option = GVAR(MissionCalls) select _i;

		if ((_option select 1) == side player) then {

			_html = _html + "<execute expression='[""" + (_option select 0) + """, false] call CALLM_fnc_CallMissionReq;'>" + (_option select 2) + "</execute>";

			if (_i < count GVAR(MissionCalls)) then {

				_html = _html + "<br/>";

			};

		};

	};

};

if (({(_x select 1) == sideUnknown} count GVAR(MissionCalls)) > 0) then {

	_html = _html + "<br/><br/><font size='18'>Call Mission Admin Options</font><br/>";

	for "_i" from 0 to count GVAR(MissionCalls) -1 do {

		_option = GVAR(MissionCalls) select _i;

		if ((_option select 1) == sideUnknown) then {

			_html = _html + "<execute expression='[""" + (_option select 0) + """, true] call CALLM_fnc_CallMissionReq;'>" + (_option select 2) + "</execute>";

			if (_i < count GVAR(MissionCalls)) then {

				_html = _html + "<br/>";

			};

		};

	};

};

player createDiaryRecord ["FW_Menu", ["Call Mission", _html]];
