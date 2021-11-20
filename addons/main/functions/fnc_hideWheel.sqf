// Acquire required data
private _display     = uiNameSpace getVariable ["NFST_GSW_Display"   , []];
private _onMouseMove = uiNameSpace getVariable ["NFST_GSW_MouseEvent", []];
private _selected    = uiNameSpace getVariable ["NFST_GSW_Selection" , []];
private _cursor      = uiNameSpace getVariable ["NFST_GSW_Cursor"    , []];
private _displayData = uiNameSpace getVariable ["NFST_GSW_Items"     , []];


// Do some cleanup
_display displayRemoveEventHandler ["MouseMoving", _onMouseMove select 0];
uiNameSpace setVariable ["NFST_GSW_Selection", []];
ctrlDelete (_cursor select 0);
{
  ctrlDelete (_x select 3);
} forEach _displayData;


// Get desired grenade
if (count _selected == 0) exitWith {};
private _selectedGrenade = _selected select 0;

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
