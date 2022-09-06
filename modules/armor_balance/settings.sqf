// Made by burn0ut7
//
//Apply armor changes true/false to all units inlcuding AI
//
//TEST YOUR CHANGES!
GVAR(enabled) = true;


//Apply to what sides
//GVAR(sides) = [west,east,resistance,civilian]; applies to all sides
//GVAR(sides) = [west]; applies only to blufor
GVAR(sides) = [west,east,resistance,civilian];


//Armor coefficient
//Multiples armors baseconfig value.
//Recommend changing only the specfic body part armor coefficient. As unarmored body parts have base armor.
//To get armor hit vaule "[_unit, _hitpoint] call ace_medical_engine_fnc_getHitpointArmor;"
//
//Damage calulation by: damage / armor
//
//Armor calulated by: base config armor * (CoefAll or CoefHitPart)
//
//No negative numbers!
//Exact effectiveness are estimates as there can be overlap with hitParts causing death to happen in more or less of an expected amount of shots

//EXAMPLE: GVAR(CoefTorso) = 1; default, no change
//EXAMPLE: GVAR(CoefTorso) = 2; armor is twice as effective at protection
//EXAMPLE: GVAR(CoefTorso) = .5; armor is half as effective at protection
//EXAMPLE: GVAR(CoefTorso) = .5; armor is half as effective at protection
//EXAMPLE: GVAR(CoefAll) = 2; GVAR(CoefHead) = 2; head armor will be twice as effective. will apply first to all body parts following other body oarts

//GVAR(CoefAll) = 1;
//GVAR(CoefHead) = 1;
//GVAR(CoefFace) = 1;
//GVAR(CoefNeck) = 1;
//GVAR(CoefChest) = 1;
//GVAR(CoefDiaphragm) = 1;
//GVAR(CoefAbdomen) = 1;
//GVAR(CoefPelvis) = 1;
//GVAR(CoefArms) = 1;
//GVAR(CoefHands) = 1;
//GVAR(CoefLegs) = 1;


//Armor base overwrite
//This overwrites the base config armor value. This is optional.
//Armor calulated by: BaseAll + BaseHitPart
//
//No negative numbers!
//Lack of variables will use default armor values
//EXAMPLE: GVAR(BaseAll) = 20; all body hitparts will have 20 armor
//EXAMPLE: GVAR(BaseAll) = 20; GVAR(BaseTorso) = 30; GVAR(BasePelvis) = 10; torso will have 30 armor points, pelvis will have 10 armor points, all others 20

//GVAR(BaseAll) = 20;
//GVAR(BaseHead) = 20;
//GVAR(BaseFace) = 20;
//GVAR(BaseNeck) = 20;
//GVAR(BaseChest) = 20;
//GVAR(BaseDiaphragm) = 20;
//GVAR(BaseAbdomen) = 20;
//GVAR(BasePelvis) = 20;
//GVAR(BaseArms) = 20;
//GVAR(BaseHands) = 20;
//GVAR(BaseLegs) = 20;
