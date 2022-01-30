#include "script_component.hpp"


params ["_unit"];

//exit if sightaid for vehicles disabled
if (!(GETMVAR(SightAidVehicles,false)) && {vehicle _unit != _unit}) exitwith {};

private _closestEnemy = _Unit call FUNC(ClosestEnemy);
private _distance = _unit distance _closestEnemy;
if (_distance > GVAR(SightAidDistance)) exitwith {};
private _knowsabouttarget = _unit knowsabout _closestEnemy;
if (_knowsabouttarget < 4) then {
	private _cansee = [objNull, "VIEW"] checkVisibility [eyePos _Unit, eyePos _closestEnemy];
	if ((_cansee > 0.6) && {(_distance < GVAR(SightAidEngageDistance))}) exitwith {
		_unit reveal [_closestEnemy,4];
		//if (vehicle _unit == _unit) then {
		//	_unit dotarget _closestEnemy;
		//	_unit fireAtTarget [_closestEnemy];
		//};
		//if (GETMVAR(UseMarkers,false)) then {
		//	LOG_2("revealing: %1 to %2, engage!",_closestEnemy,_unit);
		//};
	};
	if (_cansee > 0.05) then {
		private _revealValue = linearConversion [100,GVAR(SightAidDistance),_distance,4,GVAR(SightAidMinIncrease)];
		_unit reveal [_closestEnemy,_knowsabouttarget + _revealValue];
		if (GETMVAR(UseMarkers,false)) then {
			LOG_4("revealing: %1 to %2, old knows: %3 new: %4",_closestEnemy,_unit,_knowsabouttarget,(_unit knowsabout _closestEnemy));
		};
	};
};
