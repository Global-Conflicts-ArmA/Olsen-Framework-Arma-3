// Array containing vehicles that will have option to spawn AI driver in them
// Example: selectVehicles[] = {"BluforLandRover1", "BluforLandRover2"};
selectVehicles[] = {};

// Array containing vehicle classnames that will have option to spawn AI driver in them
// Example: VehicleClasses[] = {"Wheeled_APC_F"};
VehicleClasses[] = {};

// Use settings below to enable the module for all tracked vehicles, boats, etc in the mission
AllTanks = false;
AllCars = true;
AllShips = false;

// Enables NVG action
NVGAction = false;

// Enable to give AI drivewr vehicles the ability to flip rightside up if flipped down
FlipAction = false;

// size and position of driver view displays
topDisplay[] = {0.1,-0.22,0.5,0.25};
bottomDisplay[] = {0.1,1,0.5,0.25};

// Testmode for finding vehicle driver camera positions
TestMode = true;

// customized class config for AI driver view params
class AIViewParams {
    class vn_wheeled_m151_base {
        pos[] = {-0.5,0.04,-0.51};
        targetPos[] = {-0.51,0.38,-0.68};
    };
};
