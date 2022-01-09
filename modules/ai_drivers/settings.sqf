// Array containing vehicles that will have option to spawn AI driver in them
// Example: GVAR(AiDriversVehicles) = ["BluforLandRover1"];
GVAR(AiDriversVehicles) = [];

// Array containing vehicle classnames that will have option to spawn AI driver in them
GVAR(AiDriversVehicleClasses) = ["Wheeled_APC_F"];

// Use settings below to enable the module for all tracked vehicles, boats, etc in the mission
GVAR(AiDriversAllTanks) = false;
GVAR(AiDriversAllCars) = false;
GVAR(AiDriversAllShips) = false;

// 0 - No NVG action. 1 - Action dependent on user having NVGs. 2 - NVG action regardless of user having NVGs or not.
GVAR(AiDriversNVGAction) = false;

// Enable to give AI driver vehicles the ability to flip rightside up if flipped down
GVAR(AiDriversFlipAction) = false;
