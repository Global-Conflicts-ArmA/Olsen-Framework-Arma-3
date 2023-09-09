#include "script_component.hpp"


params ["_groupcaller", "_enemycaller", "_sidecaller"];

if (GVAR(Debug)) then {
	TRACE_3("radiocomms params",_groupcaller,_enemycaller,_sidecaller);
};

private _respondingInfantry = [];
private _respondingMotorized = [];
private _respondingMechanized = [];
private _respondingArmored = [];

// Radio friendly groups and get responses
{
	private _group = _x;
	private _units = units _group;
	private _aliveUnits = _units select {alive _x};
	private _leader = leader _group;
	private _side = side _leader;
	private _task = GETVAR(_group,Task,"NONE");
	private _position = getposATL _leader;
	private _areaAssigned = GETVAR(_group,areaAssigned,"NONE");
	private _assetType = GETVAR(_group,assetType,"INFANTRY");
	private _groupcount = count _aliveUnits;
	private _behaviour = behaviour _leader;
	private _target = GETVAR(_group,CurrentTarget,objnull);
	private _distanceToGroup = (leader _groupcaller) distance2d _leader;
	if (
		([_sidecaller, _side] call BIS_fnc_sideIsFriendly) &&
		{(_enemycaller isNotEqualTo _target)} &&
		{_distanceToGroup <= GVAR(RadioDistance)} &&
		{!(GETMVAR(RadioNeedRadio,false)) || {(_group call FUNC(hasRadioGroup)) select 0}}
	) then {
		if ([_groupcaller,_enemycaller,CBA_MissionTime,_group] call FUNC(ReinforcementResponse)) then {
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
} foreach (allGroups select {
	private _leader = leader _x;
	(GETVAR(_x,Spawned,false)) &&
	{(_groupcaller isNotEqualTo _x)} &&
	{!(isNull _leader)} &&
	{(alive _leader)} &&
	{!(GETVAR(_leader,NOAI,false))} &&
	{!(isPlayer _leader)}
});

// Act on responses
