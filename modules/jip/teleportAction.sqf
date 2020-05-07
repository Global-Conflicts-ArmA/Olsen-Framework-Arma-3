params ["", "", "_id", ["_target", leader player, [objnull]]];

if !((_target call FUNC(Alive)) && {(!(_target call FUNC(InVehicle)) || ((vehicle _target) call FUNC(getEmptyPositions) isEqualTo []))}) then {

	private _rank = -1;
	private _count = 0;
    
    (units group player) - [player] select {
        _x call FUNC(Alive)
    } apply {
        _count = _count + 1;
        if ((rankId _x > _rank) && {!(_x call FUNC(InVehicle)) || ((vehicle _x) call FUNC(getEmptyPositions) isEqualTo [])}) then {
            _rank = rankId _x;
            _target = _x;
        };
    };

	if (_rank isEqualTo -1) then {
		_target = objNull;
		if (_count isEqualTo 0) then {
			player removeAction _id;
			cutText ["No one left in the squad", 'PLAIN DOWN'];
		} else {
			cutText ["Not possible to JIP teleport to anyone, please try again later", 'PLAIN DOWN'];
		};
	};
};

if !(_target isEqualTo objnull) then {
	if (_target call FUNC(InVehicle)) then {
		player moveInAny (vehicle _target);
	} else {
		player setPos (getPos _target);
	};
	player removeAction _id;
} else {
	cutText ["Something went wrong, target doesn't exist.", 'PLAIN DOWN'];
};