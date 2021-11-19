#include "script_component.hpp"
#include "\a3\editor_f\Data\Scripts\dikCodes.h"

//[COMPONENT_NAME,"show_breathing_key", "Show Breathing", {_this call FUNC(showGameHint)}, "", [DIK_B, [false, false, false]]] call CBA_fnc_addKeybind;
//[COMPONENT_NAME, "show_gsw_key", "Show grenade selection wheel", ["player", [], -100, QUOTE( _this call FUNC(showWheel) )], [], false] call CBA_fnc_addKeybindToFleximenu;

[COMPONENT_NAME, "push_to_show_gsw", "Show grenade selection wheel", {_this call FUNC(showWheel)}, {_this call FUNC(hideWheel)}, []] call cba_fnc_addKeybind;
