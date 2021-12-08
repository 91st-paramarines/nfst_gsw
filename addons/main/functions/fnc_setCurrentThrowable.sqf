params ["_selectedGrenade"];

// Get all player grenades
private _uniformGrenades  = uniformItems  player select {_x call BIS_fnc_isThrowable && _x != _selectedGrenade};
private _vestGrenades     = vestItems     player select {_x call BIS_fnc_isThrowable && _x != _selectedGrenade};
private _backpackGrenades = backpackItems player select {_x call BIS_fnc_isThrowable && _x != _selectedGrenade};

// Remove all grenades not of the desired type
{player removeItemFromUniform  _x; false} count _uniformGrenades ;
{player removeItemFromVest     _x; false} count _vestGrenades    ;
{player removeItemFromBackpack _x; false} count _backpackGrenades;

// Put them all back
{player addItemToUniform  _x; false} count _uniformGrenades ;
{player addItemToVest     _x; false} count _vestGrenades    ;
{player addItemToBackpack _x; false} count _backpackGrenades;
