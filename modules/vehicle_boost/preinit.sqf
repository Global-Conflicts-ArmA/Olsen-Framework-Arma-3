FW_boostLastUsed = 0;

FNC_Boost = {
	params ["_vehicle"];

	if ((FW_boostLastUsed + FW_vehicleBoostDelay) > time) exitWith {};

	private _vel = velocity _vehicle;
	private _dir = direction _vehicle;
	_vehicle setVelocity [
		(_vel select 0) + (sin _dir * FW_vehicleBoostSpeed),
		(_vel select 1) + (cos _dir * FW_vehicleBoostSpeed),
		(_vel select 2)
	];

	FW_boostLastUsed = time;
};
