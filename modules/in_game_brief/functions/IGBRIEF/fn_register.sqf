#include "script_component.hpp"

/* diag_log format ["INFO: In register.."]; */

if (hasInterface) then {

	if (isNil QGVAR(sandi_barrier_index)) then { // not initialised
		GVAR(sandi_barrier_index) = 0;
		GVAR(sandi_barrier_barriers) = [];
	};
	private _id = GVAR(sandi_barrier_index);
	GVAR(sandi_barrier_index) = GVAR(sandi_barrier_index) + 1;
	GVAR(sandi_barrier_barriers) set [_id, 1];

	private _args = _this;

	private _shape = "rectangle";
	private _text  = "The AO ends here";

	private _pos       = _args select 0;
	private _xDistance = _args select 1;
	private _yDistance = _args select 2;
	private _theta     = _args select 3;
	if (count _args > 4) then {
		_shape   = _args select 4;
		_text    = _args select 5;
	} else {
		// old syntax
	};

	private _cos = cos(_theta);
	private _sin = sin(_theta);
	private _rCos = cos(_theta * -1);
	private _rSin = sin(_theta * -1);

	[{!isNull player}, {
		_this params ["_text", "_pos", "_xDistance", "_yDistance", "_cos", "_sin", "_rCos", "_rSin", "_id"];

		GVAR(loopSleep) = 10;

		[{
			_this params ["_args", "_idPFH"];
			_args params ["_text", "_pos", "_xDistance", "_yDistance", "_cos", "_sin", "_rCos", "_rSin", "_id"];

			private _disabled = false;
			if (!isNil QGVAR(sandi_barrier_disabled)) then {
				if (GVAR(sandi_barrier_disabled)) then {
					_disabled = true;
				};
			};

			private _state = GVAR(sandi_barrier_barriers) select _id;

			/* diag_log format ["INFO: Barriers = %1", GVAR(sandi_barrier_barriers)]; */

			private _playerVeh = objNull;
			if (vehicle player == player) then { // on foot
				/* diag_log("on foot"); */
				_playerVeh = player;
			} else { // in a vehicle
				/* diag_log("in vehicle"); */
				if (driver (vehicle player) == player) then { // player is driving
					/* diag_log("driver"); */
					_playerVeh = vehicle player;
				} else {
					_disabled = true;
					GVAR(loopSleep) = 1;
				};
			};

			/* diag_log format ["INFO: _state = %1", _state]; */

			if (!_disabled && (_state == 1)) then {
				/* diag_log("not null"); */
				private _x = ((getPos _playerVeh) select 0) - (_pos select 0);
				private _y = ((getPos _playerVeh) select 1) - (_pos select 1);

				private _x2 = (_cos * _x) - (_sin * _y);
				private _y2 = (_sin * _x) + (_cos * _y);

				private _move = false;
				private _newX2 = _x2;

				if (_x2 > _xDistance) then {
					_newX2 = (_xDistance -0.1);
					_move = true;
				} else { if (_x2 < (_xDistance *-1)) then {
						_newX2 = ((_xDistance -0.1) *-1);
						_move = true;
					}};
				private _newY2 = _y2;
				if (_y2 > _yDistance) then {
					_newY2 = (_yDistance -0.1);
					_move = true;
				} else { if (_y2 < (_yDistance *-1)) then {
						_newY2 = ((_yDistance -0.1) *-1);
						_move = true;
					}};

				/* diag_log format ["INFO: x2 = %1, y2 = %2, _move = %3", _x2, _y2, _move]; */

				if (_move) then {
					if (_playerVeh distance _pos < 5) then {} else {
						hintSilent _text;
						private _newX = (_rCos * _newX2) - (_rSin * _newY2);
						private _newY = (_rSin * _newX2) + (_rCos * _newY2);
						_playerVeh setPos [(_pos select 0) + _newX, (_pos select 1) + _newY, (getPos _playerVeh) select 2];
						_playerVeh setVelocity [0,0,0];
						GVAR(loopSleep) = 0.05;
					};
				} else {
					if (_x2 > (_xDistance -100)) then {
						GVAR(loopSleep) = 0.2;
					} else { if (_x2 < ((_xDistance -100) *-1)) then {
							GVAR(loopSleep) = 0.2;
						}
					};
					_newY2 = _y2;
					if (_y2 > (_yDistance -100)) then {
						GVAR(loopSleep) = 0.2;
					} else { if (_y2 < ((_yDistance -100) *-1)) then {
							GVAR(loopSleep) = 0.2;
						}
					};
				};

			} else {
				if (_state == 0) then { // delete barrier
					_idPFH call CBA_fnc_removePerFrameHandler;
				};
			};
		}, GVAR(loopSleep), [_text, _pos, _xDistance, _yDistance, _cos, _sin, _rCos, _rSin, _id]] call CBA_fnc_addPerFrameHandler;
	}, [_text, _pos, _xDistance, _yDistance, _cos, _sin, _rCos, _rSin, _id]] call CBA_fnc_waitUntilAndExecute;
	_id // return
};
