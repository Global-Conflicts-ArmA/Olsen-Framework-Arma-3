if (!isDedicated) then {

	if (isNil "sandi_barrier_index") then { // not initialised
		sandi_barrier_index = 0;
		sandi_barrier_barriers = [];
	};
	_id = sandi_barrier_index; 
	sandi_barrier_index = sandi_barrier_index +1;
	sandi_barrier_barriers set [_id, 1];

	[_id, _this] spawn {
		_id        = _this select 0;
		_args      = _this select 1;
		
		_shape = "rectangle";
		_text  = "The AO ends here";
		
		_pos       = _args select 0;
		_xDistance = _args select 1;
		_yDistance = _args select 2;
		_theta     = _args select 3;
		if (count _args > 4) then {
			_shape   = _args select 4;
			_text    = _args select 5;
		} else {
			// old syntax
		};
		
		_cos = cos(_theta);
		_sin = sin(_theta);
		_rCos = cos(_theta * -1);
		_rSin = sin(_theta * -1);

		waitUntil {!isNull player};

		while {true} do {
			scopeName "loop";
			_sleep = 10;

			_disabled = false; 
			if (!isNil "sandi_barrier_disabled") then { 
				if (sandi_barrier_disabled) then { 
					_disabled = true; 
				}; 
			};
			
			_state = sandi_barrier_barriers select _id;
			
			_playerVeh = objNull;
			if (vehicle player == player) then { // on foot
				diag_log("on foot");
				_playerVeh = player;
			} else { // in a vehicle
				diag_log("in vehicle");
				if (driver (vehicle player) == player) then { // player is driving
					diag_log("driver");
					_playerVeh = vehicle player;
				} else {
					_disabled = true;
					_sleep = 1;
				};
			};

			if (!_disabled && _state == 1) then {

				diag_log("not null");
				_x = ((getPos _playerVeh) select 0) - (_pos select 0);
				_y = ((getPos _playerVeh) select 1) - (_pos select 1);

				_x2 = (_cos * _x) - (_sin * _y);
				_y2 = (_sin * _x) + (_cos * _y);

				_move = false;
				_newX2 = _x2;
				if (_x2 > _xDistance) then {
					_newX2 = (_xDistance -0.1);
					_move = true;
				} else { if (_x2 < (_xDistance *-1)) then {
						_newX2 = ((_xDistance -0.1) *-1);
						_move = true;
					}};
				_newY2 = _y2;
				if (_y2 > _yDistance) then {
					_newY2 = (_yDistance -0.1);
					_move = true;
				} else { if (_y2 < (_yDistance *-1)) then {
						_newY2 = ((_yDistance -0.1) *-1);
						_move = true;
					}};

				if (_move) then {
					if (_playerVeh distance barrierChecker < 5) then {}else{ 
						hintSilent _text;
						_newX = (_rCos * _newX2) - (_rSin * _newY2);
						_newY = (_rSin * _newX2) + (_rCos * _newY2);
						_playerVeh setPos [(_pos select 0) + _newX, (_pos select 1) + _newY, (getPos _playerVeh) select 2];
						_playerVeh setVelocity [0,0,0];
						_sleep = 0.05;
					};
				} else {
					if (_x2 > (_xDistance -100)) then {
						_sleep = 0.2;
					} else { if (_x2 < ((_xDistance -100) *-1)) then {
							_sleep = 0.2;
						}};
					_newY2 = _y2;
					if (_y2 > (_yDistance -100)) then {
						_sleep = 0.2;
					} else { if (_y2 < ((_yDistance -100) *-1)) then {
							_sleep = 0.2;
						}};
				};

			} else {
				if (_state == 0) then { // delete barrier
					breakOut "loop";
				};
			};
			sleep _sleep;
		};

	};
	_id // return 
};