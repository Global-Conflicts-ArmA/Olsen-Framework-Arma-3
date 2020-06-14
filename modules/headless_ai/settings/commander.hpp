// AI commander options -WIP
GVAR(CommanderEnabled) = false;
GVAR(CommanderDebug) = true;
GVAR(CommanderSide) = east;
//"Random" "Aggressive" "Defensive" "Guerilla" "Probing"
GVAR(CommanderPersonality) = "Random";
GVAR(CommanderDelay) = 3;
GVAR(CommanderSkill) = 5;
// Objectives/Areas to consider, order in array determines priority of areas. Required elements: marker name, commander mission.
// Optional array elements: terrain manual define, QRF support for contact encountered in the area, minimum assets to assign for the area, asset threshold for the area (if threshold to assign cannot be met area will not be considered), maximum assets to assign for the area (leftover groups will be assigned to areas that aligns with preferred asset types), preferred asset types.
// Preferred asset types will be determined from terrain setting if not manually defined.
GVAR(CommanderAreas) = [
    [
        /* 0 Display Name */ "Kamenyy", 
        /* 1 Marker */ "area1", 
        /* 2 Mission */ "Defend", 
        /* 3 Min Assets */ 2, 
        /* 4 Max Assets */ 2, 
        /* 5 Asset Threshold */ 0, 
        /* 6 QRF Support */ true, 
        /* 7 Asset Support */ true, 
        /* 8 Withdrawal Enabled*/ false, 
        /* 9 Resource Use */ true, 
        /* 10 Preferred Types (OPTIONAL)*/ ["Infantry", "Snipers"],
        /* 11 Terrain Mode (OPTIONAL)*/ "AUTO"
    ],
    [
        /* 0 Display Name */ "Kamenyy Outskirts", 
        /* 1 Marker */ "area0", 
        /* 2 Mission */ "Patrol", 
        /* 3 Min Assets */ 0, 
        /* 4 Max Assets */ 2, 
        /* 5 Asset Threshold */ 2, 
        /* 6 QRF Support */ false, 
        /* 7 Asset Support */ false, 
        /* 8 Withdrawal Enabled*/ true, 
        /* 9 Resource Use */ false, 
        /* 10 Preferred Types (OPTIONAL)*/ ["Infantry"],
        /* 11 Terrain Mode (OPTIONAL)*/ "AUTO"
    ]
];
// 
GVAR(CommanderQRF) = ["QRF_MotorRifles"];
// "Spotted", "Threatened", "Combat", "Prolonged Combat"
GVAR(CommanderQRFThreshold) = "Combat";
GVAR(CommanderRoam) = false;
GVAR(CommanderWithdrawal) = false;
GVAR(CommanderResourcesArty) = [];
GVAR(CommanderResourcesAirStrikes) = [];
GVAR(CommanderResourcesParadrops) = [];
// Commander fills zones to maximum asset values then starts assigning to next zone, or commander assigns evenly to zones in order of precedent until max values filled
// "FILL" or "EVEN"
GVAR(CommanderFillAssignMode) = "FILL";
// Commander will assign groups that start in a zone to that zone - overlapping zones work in precedence + max asset assignments.
GVAR(CommanderAssignStartZone) = true;
