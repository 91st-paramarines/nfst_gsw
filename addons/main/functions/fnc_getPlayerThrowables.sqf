  // Get player's items
private _loadout  = getUnitLoadout player;
private _allItems = [];
for "_i" from 3 to 5 do
{
  _slotLoadout = _loadout select _i;
  if ( count _slotLoadout > 1  ) then
  {
    _allItems append (_slotLoadout select 1);
  }
};

// Get player's throwables
private _seenThrowables = [];
private _allThrowables  = [];
{
  _itemClassName = _x select 0;
  if (!(_itemClassName in _seenThrowables) && (_itemClassName call BIS_fnc_isThrowable)) then
  {
    _seenThrowables pushBack _itemClassName;
    _picture     = (getText (configFile >> 'CfgMagazines' >> _itemClassName >> 'picture'));
    _displayName = (getText (configFile >> 'CfgMagazines' >> _itemClassName >> 'displayName'));
    _allThrowables append [[_itemClassName, _picture, _displayName]]; // use pushBack
  }
} forEach _allItems;
_allThrowables sort true;

_allThrowables
