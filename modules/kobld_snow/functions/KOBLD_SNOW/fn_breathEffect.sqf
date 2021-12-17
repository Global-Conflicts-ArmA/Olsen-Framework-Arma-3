#include "script_component.hpp"

private ["_unit","_int","_nextTime", "_source", "_mylogic", "_fog"];

allUnits apply {
	_unit = _x;
	if (alive _unit) then {
		_nextTime = _unit getVariable ["myNextBreathTime", -1];
		if (_nextTime == -1) then {
			_unit setVariable ["myNextBreathTime", diag_tickTime + (1+random(3))];
			_source = "logic" createVehicleLocal (getpos _unit);
			_unit setVariable ["myBreathingParticleLogic", _source];
			if (_unit == player) then {
				_source attachTo [_unit,[0,0.1,.04], "neck"];
			} else {
				_source attachTo [_unit,[0,0.05,-0.08], "pilot"];
			};
			_unit setVariable ["myBreathingParticleSource", nil];
		};
		private _myParticleSource = _unit getVariable ["myBreathingParticleSource", nil];
		if (diag_tickTime >= _nextTime || {[_unit] call acre_api_fnc_isSpeaking && isNil "_myParticleSource"}) then {
			if (isNil "_myParticleSource") then {
				_unit setVariable ["myNextBreathTime", diag_tickTime + 0.5];
				_mylogic = _unit getVariable "myBreathingParticleLogic";
				_fog = "#particlesource" createVehicleLocal (getpos _mylogic);
				_fog setParticleParams [["\a3\data_f\ParticleEffects\Universal\Universal", 16, 12, 13,0],
					"",
					"Billboard",
					0.5,
					0.5,
					[0,0,0],
					[0, 0.0, -0.3],
					1, 1.275,    1, 0.2,
					[0, 0.2,0],
					[[1,1,1, (.0001+random(.0005))], [1,1,1, 0.01], [1,1,1, 0]],
					[1000],
					1,
					0.04,
					"",
					"",
					_mylogic];
					_fog setParticleRandom [2, [0, 0, 0], [0.25, 0.25, 0.25], 0, 0.5, [0, 0, 0, 0.1], 0, 0, 10];
					_fog setDropInterval 0.01;
					_unit setVariable ["myBreathingParticleSource", _fog];
				} else {
					if(!([_unit] call acre_api_fnc_isSpeaking)) then {
						_unit setVariable ["myNextBreathTime", diag_tickTime + (2+random(3))];
						deleteVehicle (_unit getVariable "myBreathingParticleSource");
						_unit setVariable ["myBreathingParticleSource", nil];
					};
				};
		};
	} else {
		_unit setVariable ["myNextBreathTime", -1];
		deleteVehicle (_unit getVariable "myBreathingParticleLogic");
		deleteVehicle (_unit getVariable "myBreathingParticleSource");
	};
};
