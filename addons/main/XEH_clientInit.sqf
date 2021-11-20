#include "script_component.hpp"
#include "\a3\editor_f\Data\Scripts\dikCodes.h"

[COMPONENT_NAME, "push_to_show_gsw", "Show grenade selection wheel", {_this call FUNC(showWheel)}, {_this call FUNC(hideWheel)}, []] call cba_fnc_addKeybind;
