/*
Function: LR_fnc_AddCreatorAction

Description:
	Adds an action for the mission creator that allows executing code/functions
	during the live mission.

Arguments:
	_title - The globally unique identifier of the action <STRING>
	_name - The name of the action as shown to players <STRING>
	_statement - The code executed upon calling the action, the following params are available: [_target, _caller, _args] <CODE>
	_args - Arguments for the statement script <ARRAY OF ANYTHING>

Return Values:
	None

Examples:
    (begin example)
		[
			"MissionStart",
			"Start Mission",
			{hint "Mission started!";},
			[]
		] call LR_fnc_AddCreatorAction;
	(end)

Author:
	Mokka
*/

if (!isServer) exitWith {
	_this remoteExec ["LR_fnc_AddCreatorAction", 2];
};

params ["_title", "_name", "_statement", "_args"];

CreatorActions pushBackUnique [_title, _name, _statement, _args];
publicVariable "CreatorActions";

// Stuff for single-player testing, since publicVariable EH does not fire on the
// machine where the broadcast happened (and in testing server == creator...)
if (count allPlayers < 2) then {
	[
		{
			params ["_title", "_name", "_statement", "_args"];
			if (isClass (configFile >> "CfgPatches" >> "ace_main")) then {
				_addedActions = player getVariable ["addedActions", []];

				if !(_title in _addedActions) then {

					_action = [
						_title,
						_name,
						"",
						_statement,
						{true},
						{},
						_args
					] call ace_interact_menu_fnc_createAction;

					[player, 1, ["ACE_SelfActions", "CreatorAction"], _action] call ace_interact_menu_fnc_addActionToObject;
				};

				_addedActions pushBackUnique _title;
				player setVariable ["addedActions", _addedActions];
			} else {
				_addedActions = player getVariable ["addedActions", []];

				if !(_title in _addedActions) then {

					player addAction [
						_name,
						_statement,
						_args,
						1.5,
						false,
						true,
						"",
						"true"
					];
				};

				_addedActions pushBackUnique _title;
				player setVariable ["addedActions", _addedActions];
			};
		}, [_title, _name, _statement, _args], 4
	] call CBA_fnc_waitAndExecute;
};