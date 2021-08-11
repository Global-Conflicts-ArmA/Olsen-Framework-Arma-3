#include "script_component.hpp"

[{!(GVAR(Modules) isEqualTo [])},{
	player createDiarySubject [QGVAR(Menu), "GC Framework"];

	private _modules = "<font size='18'>Global Conflicts Framework Modules</font><br/><br/>";

	for "_i" from 0 to (count GVAR(Modules) - 1) step 1 do {
		private _module = GVAR(Modules) select _i;
        _module params ["_name", "_description", "_author", ["_version", 0, [0, ""]]];
        _version = if (_version isEqualTo 0) then {
            "Legacy"
        } else {
			if (_version isEqualType 0) then {
				str _version
			} else {
				_version
			};
        };
		_modules = _modules + "<font size='16'>" + _name + "</font><br/>Version: " + _version + "<br/>Description: " + _description + "<br/>by " + _author;
		if (_i < count GVAR(Modules)) then {
			_modules = _modules + "<br/><br/>";
		};
	};

	player createDiaryRecord [QGVAR(Menu), ["Modules", _modules]];

	private _info = "
	<img image='core\logo.jpg' />
	<br /><br />
	<font size='18'>Welcome to the Global Conflicts Framework!</font><br/>
	The Global Conflicts Framework is a simple framework designed for ArmA 3. It supports modules and is easy to configure.<br/>
	<br/>
	Find out more about the framework on GitHub.<br/>
	github.com/Global-Conflicts-ArmA/Olsen-Framework-Arma-3<br/>
	<br/>
	Current Version: " + VERSIONSTR;

	player createDiaryRecord [QGVAR(Menu), ["Framework Info", _info]];
}, []] call CBA_fnc_waitUntilAndExecute;
