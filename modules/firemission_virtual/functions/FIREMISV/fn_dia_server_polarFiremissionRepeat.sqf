// Function by TinfoilHate
// Actual bits that do the virtual FM
#include "script_component.hpp"

_this spawn {
	///// Handle all the input ////////////////////////////////////////////////////////////////////////////////////////
	params ["_id", "_cancel", "_array"];

	_array params ["_obs", "_name", "_selectedAmmo", "_selectedGrid", "_selectedMils", "_selectedDist", "_selectedRnds", "_selectedGuns"];

	///// Assemble the tracking array for the firemission tracking ////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	private _batteryInfo = [_name] call FUNC(array_getBattery);

	_batteryInfo params ["", "", "", "_guns", "_disp", "_reloadTime", "_calcTime", "_flightTime", "_delayTime", "_side"];

	private _newFireArray = [_obs, _name, _selectedAmmo, _selectedGrid, _selectedMils, _selectedDist, _selectedRnds, _selectedGuns, _guns, _disp, _reloadTime, _calcTime, _flightTime, _delayTime, _side];
	private _newRepeatArray = [_id, false, _newFireArray];

	///// Get the available ammo count for the desired shells
	private _batteryAmmoCount = 0;
	([_name] call FUNC(array_getBatteryAmmo)) apply {
		_x params ["_class", "_qty"];

		if (_selectedAmmo == _class) then {
			_batteryAmmoCount = _qty;
		};
	};

	if (_batteryAmmoCount <= 0) exitWith {
		"Battery has no ammunition!" remoteExec ["hint", _obs];
	};

	[_name, false] call FUNC(array_setBatteryReady);
	[_id, false, _side] call FUNC(array_setMissionCancel);

	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	///// Calculate the target location
	private _target = [_selectedGrid, _selectedMils, _selectedDist] call FUNC(grid_mapGridToPos);

	///// Pull observer name information //////////////////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	private _obsName = "";
	tin_var_artyObservers apply {
		_x params ["_var", "_name", "_side"];

		if (_obs == _var) then {
			_obsName = _name
		};
	};

	if (_obsName == "") then {
		_obsName = toUpper(groupId (group _obs));
	};
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	///// Randomized calculation time if desired by input
	if (_calcTime isEqualType []) then {
		_calcTime = (_calcTime # 0 + (random ((_calcTime # 1) - (_calcTime # 0)) ));
	};

	///// Calculate firing time
	private _fireTime = (_selectedRnds * _reloadTime);

	///// Calculate splash time
	private _splash = 0;
	if (_fireTime > _flightTime) then {
		_splash = ((_fireTime - _flightTime) - 10);
	} else {
		if (_flightTime >= _fireTime) then {
			_splash = ((_flightTime - _fireTime) - 10);
		};
	};

	///// Add a delay so events don't overlap, this is lazy and I don't give a god damn
	if (_splash < 3) then {_splash = 3};

	///// Messages used for simulated communication ///////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	private _msg1 	= _obsName + ": " + _name + " THIS IS " + _obsName + ", FIRE FOR EFFECT, POLAR, OVER.";
	private _msg2	= _name + ": " + "THIS IS " + _name + ", FIRE FOR EFFECT, POLAR, OUT.";
	private _msg3	= _obsName + ": " + "LOCATION " + _selectedGrid + ", DIRECTION " + str(_selectedMils) + ", DISTANCE " + str(_selectedDist) + ", OVER.";
	private _msg4	= _name + ": " + "LOCATION " + _selectedGrid + ", DIRECTION " + str(_selectedMils) + ", DISTANCE " + str(_selectedDist) + ", OUT.";
	private _msg5	= _name + ": " + _obsName + ", " + str(_selectedRnds) + " ROUNDS, TARGET " + _id + ", OVER.";
	private _msg6	= _obsName + ": " + _name + ", " + str(_selectedRnds) + " ROUNDS, TARGET " + _id + ", OUT.";
	private _msg7	= _name + ": " + _obsName + ", SHOT, OVER";
	private _msg8	= _obsName + ": " + _name + ", SHOT, OUT";
	private _msg9	= _name + ": " + _obsName + ", SPLASH, OVER";
	private _msg10	= _obsName + ": " + _name + ", SPLASH, OUT";
	private _msg11	= _name + ": " + _obsName + ", ROUNDS COMPLETE, OVER";
	private _msg12	= _obsName + ": " + _name + ", ROUNDS COMPLETE, OUT";
	private _msg13	= _obsName + ": " + _name + ", " + _id + " CHECK FIRING, OVER";
	private _msg14	= _name + ": " + _obsName + ", " + _id + " CHECK FIRING, OUT";
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	///// Initial call for fire
	["tin_evt_fireMessage",
		[
			[1, _msg1, _side],
			[1, _msg2, _side],
			[1, _msg3, _side],
			[1, _msg4, _side],
			[1, _msg5, _side],
			[1, _msg6, _side]
		]
	] call CBA_fnc_globalEvent;

	///// Shorter calc time for known fire missions
	sleep (_calcTime / 4);

	///// Check for mission cancellation pre-firing ///////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	private _cancelMission = [_id] call FUNC(array_getMissionCancel);

	///// Check firing message
	if (_cancelMission) exitWith {
		["tin_evt_fireMessage",
			[
				[1, _msg13, _side],
				[1, _msg14, _side]
			]
		] call CBA_fnc_globalEvent;

		sleep 2;

		[_name, true] call FUNC(array_setBatteryReady);
	};
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	///// Shot message
	["tin_evt_fireMessage",
		[
			[1, _msg7, _side],
			[1, _msg8, _side]
		]
	] call CBA_fnc_globalEvent;

	///// Separates out the splash call from the actual firing ////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	[_fireTime, _splash, _side, _msg9, _msg10, _name] spawn {
		params ["_fireTime", "_splash", "_side", "_msg9", "_msg10", "_name"];

		sleep _fireTime;

		[_name, true] call FUNC(array_setBatteryReady);

		sleep _splash;

		["tin_evt_fireMessage",	//Splash
			[
				[1, _msg9, _side],
				[1, _msg10, _side]
			]
		] call CBA_fnc_globalEvent;

		sleep 8;
	};
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	///// Get the available ammo count for the desired shells
	_batteryAmmoCount = 0;
	([_name] call FUNC(array_getBatteryAmmo)) apply {
		_x params ["_class", "_qty"];

		if (_selectedAmmo == _class) then {
			_batteryAmmoCount = _qty;
		};
	};

	///// Actually "fire" the guns
	private _gunsFired = 0;

	for "_i" from 1 to _selectedRnds do {
		///// Checking for cancellation mid-firing
		_cancelMission = [_id] call FUNC(array_getMissionCancel);

		if (_cancelMission) exitWith {
			["tin_evt_fireMessage",	//Cancelled
				[
					[1, _msg13, _side],
					[1, _msg14, _side]
				]
			] call CBA_fnc_globalEvent;

			sleep 2;

			[_name, true] call FUNC(array_setBatteryReady);
		};

		for "_i" from 1 to _selectedGuns do {
			if (_selectedRnds > 0 && _batteryAmmoCount > 0) then {
				_gunsFired = _gunsFired + 1;
				_batteryAmmoCount = _batteryAmmoCount - 1;
			};
		};

		if (_selectedRnds > 0) then {sleep _reloadTime};
	};

	///// Adjust battery ammo remaining
	[_name,_selectedAmmo,_batteryAmmoCount] call FUNC(array_setBatteryAmmo);

	///// Rounds complete message
	["tin_evt_fireMessage",
		[
			[1, _msg11, _side],
			[1, _msg12, _side]
		]
	] call CBA_fnc_globalEvent;

	sleep (_splash + 8);

	private _ammoClass = getText (configFile >> "CfgMagazines" >> _selectedAmmo >> "ammo");

	private _rounds = 0;
	while {_rounds < _selectedRnds && _gunsFired > 0} do {
		for "_i" from 1 to _selectedGuns do {
			private _fireTarget = [_target, _disp] call CBA_fnc_randPos;

			private _newDelayTime = 0;
			if (_delayTime isEqualType []) then {
				_newDelayTime = (_delayTime # 0 + (random ((_delayTime # 1) - (_delayTime # 0)) ));
			};
			sleep _newDelayTime;

			private _mortarStrike = _ammoClass createVehicle [_fireTarget # 0, _fireTarget # 1, 450];
			_mortarStrike setVelocity [0, 0, -225];

			/*
			_mortarLogic = "Land_HelipadEmpty_F" createVehicle _strikeLocation;
			_mortarLogic setPosATL _strikeLocation;

			_sound = selectRandom ["mortar1","mortar2"];
			[_mortarLogic, [_sound,500]] remoteExec ["say3D"];
			*/

			_gunsFired = _gunsFired - 1;
		};

		_rounds = _rounds + 1;

		sleep _reloadTime;
	};
};
