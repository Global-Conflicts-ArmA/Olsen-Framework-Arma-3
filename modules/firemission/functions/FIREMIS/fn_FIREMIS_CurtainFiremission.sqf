#include "script_component.hpp"

#include "..\..\Dia\Dia_Global.sqf"

if (isServer) then
{
_handle = _this spawn
{
		private _unit = _this select 0;
		{
			_tempArray = _this;
			_tempArray set [0,_x];
			_x setVariable [VAR_SART_ARTFMTEXT,_tempArray call FUNC(FIREMIS_GetCurtainFiremissionText),true];
				[_x , true] call FNC_SetArtyReadyStatus;
		} forEach _unit;
		private _startPoint = _this select 1;
		private _endPoint = _this select 2;
		private _width = _this select 3;
		private	_burstCount = _this select 4;
		private	_burstSize = _this select 5;
		private	_burstWait = _this select 6;
		private	_minSpottedDistance = _this select 7;

		private	_roundType = _this select 8;
		private _roundClassName = ((_unit call FNC_GetArtyAmmo) select _roundType) select 0 ;
		{
			[_x , true] call FNC_SetArtyReadyStatus;
			_x setVariable [VAR_SART_ARTFMTEXT,_this call FUNC(FIREMIS_GetPointFiremissionText),true];
			[_x, 0,_burstCount * _burstSize] call FNC_SetArtyFiremissionRoundsRequired;
		} forEach _unit;
		private	_fireRate = [];
		sleep((_unit call FNC_GetArtyAimTime));
		private	_dis = 1000;
		private	_tempAcc = ((_unit select 0) getVariable [VAR_SART_ARTSPOTACCURACY,MEANSPOTTINGACCURACY]) + 1;
		private	_dir = _endPoint vectorDiff  _startPoint;
		_dir = _dir vectorMultiply (1 /_burstCount);

		private _rightDir = (vectorNormalized _dir) vectorCrossProduct [0,1,0];
		private _leftDir = [0,0,0] vectorDiff _rightDir;
		private _interval = _width / ( count _unit);
		private _startingSpots = [];
		private _leftEdge = _startPoint vectorAdd (_leftDir vectorMultiply ( _width / 2));
		private _tempCount = 0;
		{
				_startingSpots pushBack (_leftEdge vectorAdd (_rightDir vectorMultiply  (_tempCount * _interval)));
				_fireRate pushBack (_x call FNC_ArtGetFireRate);
				_tempCount = _tempCount + 1;
		} forEach _unit;
		[_unit,_startPoint,_roundClassName ] call FUNC(FIREMIS_InternalSpottingFiremission);
		//spotting rounds finished


		sleep( (_unit getVariable [VAR_SART_ARTCALCSPEED,MEANCALCULATIONTIME]) + 1);
		for "_i" from 0 to _burstCount do
		{
				_row = 0;
				{
						[_unit,(_startingSpots select _row) vectorAdd (_dir vectorMultiply _i),0,_burstSize,_roundClassName] call FUNC(FIREMIS_InternalFiremission);
						[_x, ((_x getVariable [VAR_SART_ARTROUNDSFIRED,[0,0]]) select 1) + _burstSize,_burstCount * _burstSize] call FNC_SetArtyFiremissionRoundsRequired;
						_row = _row + 1;
				}forEach _unit;
					sleep((((_fireRate select 0) * ((_unit select 0) getVariable [VAR_SART_ARTFIRERATE,MEANFIRERATE]) ) * _burstSize) max _burstWait);
		};
		{
				[_x, 0,0] call FNC_SetArtyFiremissionRoundsRequired;
				[_x , false] call FNC_SetArtyReadyStatus;
				[_x,objNULL] call FNC_SetArtyCaller;
		} forEach _unit;
	};
	{
		_x setVariable [VAR_SART_FMHANDLE,_handle,true];
	} forEach (_this select 0);
};
