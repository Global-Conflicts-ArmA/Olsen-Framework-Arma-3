#include "script_component.hpp"


private ["_Unit", "_TargetPosition", "_unit", "_NewPosition", "_Accuracy", "_Shake", "_Speed", "_SpotTime", "_SpotDistance", "_RankReturn"];

params ["_Unit","_DiagLastCheck","_TargetPosition"];

_DiagLastCheck = CBA_MissionTime;
if (_TargetPosition isEqualTo [0,0,0]) then
{
	//_target = assignedTarget _unit;
	private _target = _Unit call FUNC(ClosestEnemy);
	if (_target isEqualTo [0,0,0]) exitwith {};
	_TargetPosition = getpos _target;
}
else
{
	//_target = assignedTarget _unit;
	private _target = _Unit call FUNC(ClosestEnemy);if (_target isEqualTo [0,0,0]) exitwith {};
	_NewPosition = getpos _Target;


	if (_TargetPosition distance _NewPosition < 30 && {(_unit knowsabout _target) > 0.1}) then
	{
		_Accuracy = _Unit skill "aimingAccuracy";
		_Shake = _Unit skill "aimingShake";
		_Speed = _Unit skill "aimingSpeed";
		_SpotTime = _Unit skill "spotTime";
		_SpotDistance = _Unit skill "spotDistance";

		if (PZAI_RainImpact) then
		{
			private _WeatherCheck = (rain)/PZAI_RainPercent;
			_Unit setSkill ["aimingAccuracy",(_Accuracy + 0.1) - _WeatherCheck];
			_Unit setSkill ["aimingShake",(_Shake + 0.1) - _WeatherCheck];
			_Unit setSkill ["aimingSpeed",(_Speed + 0.1) - _WeatherCheck];
			_Unit setSkill ["spotTime",(_SpotTime + 0.1) - _WeatherCheck];
			_Unit setSkill ["spotDistance",(_SpotDistance + 0.1) - _WeatherCheck];
		}
		else
		{
			_Unit setSkill ["aimingAccuracy",(_Accuracy + 0.1)];
			_Unit setSkill ["aimingShake",(_Shake + 0.1)];
			_Unit setSkill ["aimingSpeed",(_Speed + 0.1)];
			_Unit setSkill ["spotTime",(_SpotTime + 0.1)];
			_Unit setSkill ["spotDistance",(_SpotDistance + 0.1)];
		};

		if (GVAR(Debug)) then
		{
			[_Unit,"Target has not moved...Increasing accuracy :D",15,20000] remoteExec ["3DText",0];
		};
	}
	else
	{
		_Accuracy = _Unit skill "aimingAccuracy";
		_Shake = _Unit skill "aimingShake";
		_Speed = _Unit skill "aimingSpeed";
		_SpotTime = _Unit skill "spotTime";
		_SpotDistance = _Unit skill "spotDistance";

		if (PZAI_RainImpact) then
		{
		private _WeatherCheck = (rain)/PZAI_RainPercent;
		_Unit setSkill ["aimingAccuracy",_Accuracy - _WeatherCheck];
		_Unit setSkill ["aimingShake",_Shake - _WeatherCheck];
		_Unit setSkill ["aimingSpeed",_Speed - _WeatherCheck];
		_Unit setSkill ["spotTime",_SpotTime - _WeatherCheck];
		_Unit setSkill ["spotDistance",_SpotDistance - _WeatherCheck];
		}
		else
		{
			_Unit setSkill ["aimingAccuracy",_Accuracy];
			_Unit setSkill ["aimingShake",_Shake];
			_Unit setSkill ["aimingSpeed",_Speed];
			_Unit setSkill ["spotTime",_SpotTime];
			_Unit setSkill ["spotDistance",_SpotDistance];
		};

		if (GVAR(Debug)) then
		{
			[_Unit,"Target has moved...Reset Accuracy :<",15,20000] remoteExec ["3DText",0];
		};
	};
	_TargetPosition = _NewPosition;
};

private _ReturnedArray = [_DiagLastCheck,_TargetPosition];

_ReturnedArray
