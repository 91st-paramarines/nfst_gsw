#include "script_component.hpp"

private _hasACE = isClass (configfile >> "CfgPatches" >> "ace_common");

if (hasInterface && _hasACE) then
{
  private _childrenStatements =
  {
    private _actions = [];

    // Get player frags
    private _playerThrowables = [] call nfst_fnc_getPlayerThrowables;

    // Add children actions
    {
      private _action = [format ["NFST_GSW_%1", _x select 0], _x select 2, _x select 1, {[_this select 2] call nfst_fnc_setCurrentThrowable;}, {true}, {}, _x select 0] call ace_interact_menu_fnc_createAction;
      _actions pushBack [_action, [], objNull];
    } forEach _playerThrowables;

    _actions
  };

  private _action = ["NFST_GSW", "Grenades", "E:\x\nfst_gsw\addons\main\data\grenadeIcon.paa", {}, {true}, _childrenStatements] call ace_interact_menu_fnc_createAction;
  [(typeOf player), 1, ["ACE_SelfActions", "ACE_Equipment"], _action] call ace_interact_menu_fnc_addActionToClass;
};
