#include "script_component.hpp"


params ["_groupcaller", ["_enemycaller", objnull, [objnull]]];

private _sidecaller = side _groupcaller;
private _posCaller = getposATL leader _groupcaller;

if (GVAR(Debug)) then {
	TRACE_3("radiocomms params",_groupcaller,_enemycaller,_sidecaller);
};

private _respondingInfantry = [];
private _respondingMotorized = [];
private _respondingMechanized = [];
private _respondingArmored = [];

private _knownEnemy = (_enemycaller isNotEqualTo objnull);
private _nearbyEnemy = [];
private _enemyHasArmored = false;
private _enemyHasVehicles = false;
private _reportedLocation = [_posCaller, 30] call CBA_fnc_randPos;
//IGNORE_PRIVATE_WARNING ["_x"]
if (_knownEnemy) then {
	_nearbyEnemy = [_enemycaller, 50] call FUNC(nearbyFriendlyEntities);
    _nearbyEnemy params [["_nearbyInfantry", [], [[]]], ["_nearbyCars", [], [[]]], ["_nearbyAPCs", [], [[]]], ["_nearbyTanks", [], [[]]]];
    _enemyHasVehicles = (_nearbyCars isNotEqualTo []) || {(_nearbyAPCs isNotEqualTo [])} || {(_nearbyTanks isNotEqualTo [])};
    _enemyHasArmored = _enemyHasVehicles && {(_nearbyAPCs isNotEqualTo []) || {(_nearbyTanks isNotEqualTo [])}};
	_reportedLocation = [_nearbyEnemy select 0, 30] call CBA_fnc_randPos;
};

// Radio friendly groups and get responses
allGroups select {
	private _leader = leader _x;
	(GETVAR(_x,Spawned,false)) &&
	{(_groupcaller isNotEqualTo _x)} &&
	{!(isNull _leader)} &&
	{(alive _leader)} &&
	{!(GETVAR(_leader,NOAI,false))} &&
	{!(isPlayer _leader)} &&
	{!([_x] call FUNC(isInCombat))} &&
    {!(GETVAR(_x,Reinforcing,false))}
} apply {
	private _group = _x;
	//private _aliveUnits = units _group select {alive _x};
	private _leader = leader _group;
	private _side = side _leader;
	//private _task = GETVAR(_group,Task,"NONE");
	//private _position = getposATL _leader;
	//private _areaAssigned = GETVAR(_group,areaAssigned,"NONE");
	private _assetType = GETVAR(_group,assetType,"Infantry");
	//private _groupcount = count _aliveUnits;
	//private _behaviour = behaviour _leader;
	private _target = GETVAR(_group,CurrentTarget,objnull);
	private _distanceToGroup = (leader _groupcaller) distance2d _leader;
    if (
    	([_sidecaller, _side] call BIS_fnc_sideIsFriendly) &&
    	{!_knownEnemy || {_target isEqualTo objnull} || {!(_target in _nearbyEnemy)}} &&
    	{_distanceToGroup <= GVAR(RadioDistance)} &&
    	{!(GETMVAR(RadioNeedRadio,false)) || {(_group call FUNC(hasRadioGroup)) select 0}}
    ) then {
    	private _response = [_group, _groupcaller, _distanceToGroup, _reportedLocation, CBA_MissionTime, _nearbyEnemy, _enemyHasArmored] call FUNC(ReinforcementResponse);
    	TRACE_3("reinforcement response",_groupcaller,_group,_response);
    	if (_response) then {
    		switch _assetType do {
    		    case "Infantry": {
    				_respondingInfantry pushBackUnique _group;
    		    };
    			case "Motorized": {
    				_respondingMotorized pushBackUnique _group;
    		    };
    			case "Mechanized": {
    				_respondingMechanized pushBackUnique _group;
    		    };
    			case "Armored": {
    				_respondingArmored pushBackUnique _group;
    		    };
    		    default {
    				_respondingInfantry pushBackUnique _group;
    		    };
    		};
    	};
    };
};

private _groupCount = count _respondingInfantry + count _respondingMotorized + count _respondingMechanized + count _respondingArmored;
if (GVAR(Debug)) then {
	TRACE_2("groups responding for call",_groupcaller,_groupCount);
};

// Act on responses
private _veryCloseGroups = [];
[_respondingInfantry, _respondingMotorized, _respondingMechanized, _respondingArmored] apply {
    _x select {
        _x isNotEqualTo [] &&
        {(leader _x distance2d _posCaller) <= 250}
    } apply {
    	_veryCloseGroups pushBackUnique _x;
    };
};

if (GVAR(Debug)) then {
	TRACE_2("verclosegroups for call",_groupcaller,_veryCloseGroups);
};

private _targetPos = if (_knownEnemy) then {
	[_nearbyEnemy select 0, 30] call CBA_fnc_randPos
} else {
	[_posCaller, 30] call CBA_fnc_randPos
};

private _reinforcingGroup = grpNull;

if (_knownEnemy) then {
	if (_veryCloseGroups isNotEqualTo []) then {
		_veryCloseGroups apply {
            TRACE_2("set to reinforce CombatAttack",_x,_targetPos);
		    [_x, _targetPos] call FUNC(CombatAttack);
		};
	} else {
        //IGNORE_PRIVATE_WARNING ["_x"];
        _respondingInfantry = [_respondingInfantry, [], {(leader _x distance2d _posCaller)}, "ASCEND"] call BIS_fnc_sortBy;
        _respondingMotorized = [_respondingMotorized, [], {(leader _x distance2d _posCaller)}, "ASCEND"] call BIS_fnc_sortBy;
        _respondingMechanized = [_respondingMechanized, [], {(leader _x distance2d _posCaller)}, "ASCEND"] call BIS_fnc_sortBy;
        _respondingArmored = [_respondingArmored, [], {(leader _x distance2d _posCaller)}, "ASCEND"] call BIS_fnc_sortBy;
		private _enemyCount = count _nearbyEnemy;
		if (_enemyCount <= 8) then {
			_reinforcingGroup = if (_respondingInfantry isNotEqualTo []) then {
				 _respondingInfantry select 0;
			} else {
				if (_respondingMotorized isNotEqualTo []) then {
					_respondingMotorized select 0;
				} else {
					if (_respondingMechanized isNotEqualTo []) then {
						_respondingMechanized select 0;
					} else {
						if (_respondingArmored isNotEqualTo []) then {
							_respondingArmored select 0;
						} else {
							grpNull
						};
					};
				};
			};
		} else {
			_reinforcingGroup = if (_respondingMechanized isNotEqualTo []) then {
				_respondingMechanized select 0;
			} else {
				if (_respondingMotorized isNotEqualTo []) then {
					_respondingMotorized select 0;
				} else {
					if (_respondingArmored isNotEqualTo []) then {
						_respondingArmored select 0;
					} else {
						if (_respondingInfantry isNotEqualTo []) then {
							_respondingInfantry select 0;
						} else {
							grpNull
						};
					};
				};
			};
		};
	};
} else {
	if (_veryCloseGroups isNotEqualTo []) then {
		{
            TRACE_2("set to reinforce CombatAttack",_x,_targetPos);
		    [_x, _targetPos] call FUNC(CombatAttack);
            SETVAR(_x,Reinforcing,true);
            [{
                _this params ["_group", "_pos"];
                leader _group distance2D _pos <= 100
        	},{
                _this params ["_group", "_pos"];
                private _distance = leader _group distance2D _pos;
                TRACE_2("set reinforcing to false",_group,_distance);
        	    SETVAR(_group,Reinforcing,false);
        	}, [_x, _targetPos]] call CBA_fnc_waitUntilAndExecute;
		} forEach _veryCloseGroups;
	} else {
        //IGNORE_PRIVATE_WARNING ["_x"];
        _respondingInfantry = [_respondingInfantry, [], {(leader _x distance2d _posCaller)}, "ASCEND"] call BIS_fnc_sortBy;
        _respondingMotorized = [_respondingMotorized, [], {(leader _x distance2d _posCaller)}, "ASCEND"] call BIS_fnc_sortBy;
        _respondingMechanized = [_respondingMechanized, [], {(leader _x distance2d _posCaller)}, "ASCEND"] call BIS_fnc_sortBy;
        _respondingArmored = [_respondingArmored, [], {(leader _x distance2d _posCaller)}, "ASCEND"] call BIS_fnc_sortBy;
		_reinforcingGroup = if (_respondingInfantry isNotEqualTo []) then {
			_respondingInfantry select 0
		} else {
			if (_respondingMotorized isNotEqualTo []) then {
				_respondingMotorized select 0
			} else {
				if (_respondingMechanized isNotEqualTo []) then {
					_respondingMechanized select 0
				} else {
					if (_respondingArmored isNotEqualTo []) then {
						_respondingArmored select 0
					} else {
						grpnull
					};
				};
			};
		};
	};
};

if (_reinforcingGroup isEqualTo grpNull) then {
	if (GVAR(Debug)) then {
		TRACE_1("no successful calls for",_groupcaller);
	};
} else {
    TRACE_2("set to reinforce CombatAttack",_reinforcingGroup,_targetPos);
    private _distance = leader _reinforcingGroup distance2D _targetPos;
    if (_distance >= 300) then {
        [_reinforcingGroup, _targetPos, "ATTACK"] call FUNC(CombatMoveTo);
    } else {
        [_reinforcingGroup, _targetPos] call FUNC(CombatAttack);
    };
    SETVAR(_reinforcingGroup,Reinforcing,true);
    [{
        _this params ["_group", "_pos"];
        leader _group distance2D _pos <= 100
	},{
        _this params ["_group", "_pos"];
        private _distance = leader _group distance2D _pos;
        TRACE_2("set reinforcing to false",_group,_distance);
	    SETVAR(_group,Reinforcing,false);
	}, [_reinforcingGroup, _targetPos]] call CBA_fnc_waitUntilAndExecute;
};
