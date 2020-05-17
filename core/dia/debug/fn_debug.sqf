#include "..\..\script_macros.hpp"

FUNC(DebugMessage) = {};

if !(hasInterface) exitWith {};

if (GVAR(DebugMessagesEnabled)) then {
	100 cutRsc ["DIA_DEBUG", "PLAIN"];
	private _someText = 4001;
	private _text = "";
	
	{
		_text = _text + _x + "<br></br><br></br>";
	} forEach GVAR(DebugMessages);
	
	((uiNamespace getVariable QGVAR(Debug)) displayCtrl _someText) ctrlSetStructuredText parseText _text;

	FUNC(DebugMessage) = {
		params ["_message"];
		private _someText = 4001;
		private _found = false;
		
		{
			if (_x isEqualTo _message) exitWith {
				_found = true;
			};
		} forEach GVAR(DebugMessages);
		
		if !(_found) then {
			GVAR(DebugMessages) set [count GVAR(DebugMessages), _message];
			_text = "";
			{
				_text = _text + _x + "<br></br><br></br>";	
			} forEach GVAR(DebugMessages);
			((uiNamespace getVariable QGVAR(Debug)) displayCtrl _someText) ctrlSetStructuredText parseText _text;
		};
	};
};
