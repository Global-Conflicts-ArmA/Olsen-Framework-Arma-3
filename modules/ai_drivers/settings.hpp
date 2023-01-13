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

/* Test Mode for finding vehicle driver camera positions
When TestMode is enabled vehicles will be given an ace interaction to enable (external action, when not in veh)
movement and crouch/stand up keys will control the two orbs (yellow orb is the view position, red is target dir pos)
spacebar will switch between controls moving the view (yellow orb) and the target (red orb)
pressing escape will release the controls from the test mode action as well as copy the vehicle class type and position data
you will be able to generate a config class below to correct the AI driver view with that data
target dir pos will determine the angle of the camera in the driver view
there is a driver view preview display as well as an AI driver that will spawn in so you can adjust around their model
the view position doesn't need to be exactly where the driver is, up to the mission maker
*/
TestMode = true;

// customized class config for AI driver view params
class AIViewParams {
    // vehicle class (it works with inheritance, so all M151 jeeps will inherit this config from the m151_base class)
    class vn_wheeled_m151_base {
        // position data generated from test mode
        pos[] = {-0.5,0.04,-0.51};
        targetPos[] = {-0.51,0.38,-0.68};
    };
};
