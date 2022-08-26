#include "script_component.hpp"

if (isServer) then
{
private _handle = _this spawn
{
		private _unit = _this select 0;
		{
			private _tempArray = _this;
			_tempArray set [0,_x];
			_x setVariable [VAR_SART_ARTFMTEXT,_tempArray call FUNC(GetCurtainFiremissionText),true];
				[_x , true] call FUNC(Dia_SetArtyReadyStatus);
		} forEach _unit;
		private _startPoint = _this select 1;
		private _endPoint = _this select 2;
		private _width = _this select 3;
		private	_burstCount = _this select 4;
		private	_burstSize = _this select 5;
		private	_burstWait = _this select 6;

		private	_roundType = _this select 8;
		private _roundClassName = ((_unit call FUNC(Dia_GetArtyAmmo)) select _roundType) select 0 ;
		{
			[_x , true] call FUNC(Dia_SetArtyReadyStatus);
			_x setVariable [VAR_SART_ARTFMTEXT,_this call FUNC(GetPointFiremissionText),true];
			[_x, 0,_burstCount * _burstSize] call FUNC(Dia_SetArtyFiremissionRoundsRequired);
		} forEach _unit;
		private	_fireRate = [];
		sleep((_unit call FUNC(Dia_GetArtyAimTime)));
		/* private	_dis = 1000; */
		/* private	_tempAcc = ((_unit select 0) getVariable [VAR_SART_ARTSPOTACCURACY,MEANSPOTTINGACCURACY]) + 1; */
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
		[_unit,_startPoint,_roundClassName ] call FUNC(InternalSpottingFiremission);
		//spotting rounds finished


		sleep( (_unit getVariable [VAR_SART_ARTCALCSPEED,MEANCALCULATIONTIME]) + 1);
		for "_i" from 0 to _burstCount do
		{
				private _row = 0;
				{
						[_unit,(_startingSpots select _row) vectorAdd (_dir vectorMultiply _i),0,_burstSize,_roundClassName] call FUNC(InternalFiremission);
						[_x, ((_x getVariable [VAR_SART_ARTROUNDSFIRED,[0,0]]) select 1) + _burstSize,_burstCount * _burstSize] call FUNC(Dia_SetArtyFiremissionRoundsRequired);
						_row = _row + 1;
				}forEach _unit;
					sleep((((_fireRate select 0) * ((_unit select 0) getVariable [VAR_SART_ARTFIRERATE,MEANFIRERATE]) ) * _burstSize) max _burstWait);
		};
		{
				[_x, 0,0] call FUNC(Dia_SetArtyFiremissionRoundsRequired);
				[_x , false] call FUNC(Dia_SetArtyReadyStatus);
				[_x,objNULL] call FUNC(Dia_SetArtyCaller);
		} forEach _unit;
	};
	{
		_x setVariable [VAR_SART_FMHANDLE,_handle,true];
	} forEach (_this select 0);
};
