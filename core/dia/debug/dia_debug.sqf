#include "..\..\script_macros.hpp"

FNC_DebugMessage = {};

if (!isDedicated) then {
	
	if (GVAR(DebugMessagesEnabled)) then {
		
		100 cutRsc ["DIA_DEBUG", "PLAIN"];
		
		private ["_someText", "_text"];
		
		_someText = 4001;
		
		_text = "";
		
		{
		
			_text = _text + _x + "<br></br><br></br>";
			
		} forEach GVAR(DebugMessages);
		
		((uiNamespace getVariable QGVAR(Debug)) displayCtrl _someText) ctrlSetStructuredText parseText _text;

		FNC_DebugMessage = {
			
			private ["_someText", "_message", "_found", "_text"];
			
			_someText = 4001;
			
			_message = _this;
			
			_found = false;
			
			{
				
				if (_x == _message) exitWith {
					
					_found = true;
					
				};
			
			} forEach GVAR(DebugMessages);
			
			if (!_found) then {
			
				GVAR(DebugMessages) set [count GVAR(DebugMessages), _message];
				
				_text = "";
				
				{
				
					_text = _text + _x + "<br></br><br></br>";
					
				} forEach GVAR(DebugMessages);
				
				((uiNamespace getVariable QGVAR(Debug)) displayCtrl _someText) ctrlSetStructuredText parseText _text;
			
			};
		};
	};
};