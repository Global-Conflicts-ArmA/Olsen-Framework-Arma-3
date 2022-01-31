// AI commander options -WIP
feature = false;
debug = true;
side = east;
//"Random" "Aggressive" "Defensive" "Guerilla" "Probing"
personality = "Random";
delay = 3;
skill = 5;
//
QRF[] = {"QRF_MotorRifles"};
// "Spotted", "Threatened", "Combat", "Prolonged Combat"
QRFThreshold = "Combat";
roam = false;
withdrawal = false;
resourcesArty = [];
resourcesAirStrikes = [];
resourcesParadrops = [];
// Commander fills zones to maximum asset values then starts assigning to next zone, or commander assigns evenly to zones in order of precedent until max values filled
// "FILL" or "EVEN"
fillAssignMode = "FILL";
// Commander will assign groups that start in a zone to that zone - overlapping zones work in precedence + max asset assignments.
assignStartZone = true;

// Objectives/Areas to consider, order in array determines priority of areas. Required elements: marker name, commander mission.
// Optional array elements: terrain manual define, QRF support for contact encountered in the area, minimum assets to assign for the area, asset threshold for the area (if threshold to assign cannot be met area will not be considered), maximum assets to assign for the area (leftover groups will be assigned to areas that aligns with preferred asset types), preferred asset types.
// Preferred asset types will be determined from terrain setting if not manually defined.
class Areas {
    class Kamenyy {
        marker = "area1";
        mission = "defend";
        minAssets = 2;
        maxAssets = 2;
        assetThreshold = 0;
        qrfSupport = true;
        assetSupport = true;
        withdrawal = true;
        resourceUse = true;
        preferedTypes[] = {"Infantry", "Snipers"};
        terainMode = "Auto";
    };
};
