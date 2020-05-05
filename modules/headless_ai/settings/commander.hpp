// AI commander options -WIP
GVAR(CommanderEnabled) = false;
GVAR(CommanderSide) = "EAST";
//"Random" "Aggressive" "Defensive" "Guerilla" "Probing"
GVAR(CommanderPersonality) = "Random";
GVAR(CommanderDelay) = 3;
GVAR(CommanderSkill) = 5;
// Objectives/Areas to consider, order in array determines priority of areas. Required elements: marker name, commander mission.
// Optional array elements: terrain manual define, QRF support for contact encountered in the area, minimum assets to assign for the area, asset threshold for the area (if threshold to assign cannot be met area will not be considered), maximum assets to assign for the area (leftover groups will be assigned to areas that aligns with preferred asset types), preferred asset types.
// Preferred asset types will be determined from terrain setting if not manually defined.
// ["_marker","_mission","_min","_max","_threshold","_QRFSupport","_assetSupport","_withdrawalEnabled","_resourceUse","_preferredTypes","_terrainMode"];
GVAR(CommanderAreas) = [
    ["area1", "Defend", 2, 2, 0, true, true, false, true, ["Infantry", "Snipers"]],
    ["area0", "Patrol", 0, 2, 2, false, false, true,  false, ["Infantry"]],
    ["area2", "Patrol", 0, 4, 2, false, false, true,  false, ["Motorized", "Mechanized", "Armor"]],
    ["area3", "Recon", 0, 2, 1, false]
];
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
