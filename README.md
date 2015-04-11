# SpawnBike
Darce's Deploy vehicles script
==================
# What it does

1. Allows players to deploy a vehicle.  Difference is that it checks for components required to build and hides options which cannot be deployed.
2. So, if player has everything required for a mozzie then he gets a choice of three builds.  When he (yeah, or she) selects an option it gets built directly.
3. That's right, no more build a bike, upgrade it to a motorcycle and upgrade that to a mozzie.  Just build a damned mozzie!
4. For neatness, the same deploy.sqf also packs the deployable and - wait for it - places the parts into the players backpack (or in front of the player if they have no backpack or not enough room for all the items).
5. Finally, the items are placed in front of the player regardless of whether they are on the ground or on top of a building.  No more disappearing bits and bobs.

# Install Instructions

1. This modifies/replaces your existing spawn bike completely.  If you don't have a spawnbike routine then you'll have to also grab something like [Mudzereli's Click Actions](https://github.com/mudzereli/DayZEpochClickActions) to add right click options to the toolbox to start the process.

1. Delete your existing spawnbike files, leaving the folder
2. Copy menu.sqf, deploy.sqf and init.sqf into the spawnbike folder

1. Open your fn_selfActions.sqf and replace the existing spawnbike entries with this; 
	~~~~java
========== spawn vehicle start ===============
if(DeployBikeScript)then{
	_deployables =["Old_bike_TK_CIV_EP1","TT650_Civ","CSJ_GyroC"];
	if((speed player <= 1) && typeof cursorTarget in _deployables && _canDo) then {
	_thing = typeof cursorTarget;
	if (s_player_deploy < 0) then {
			s_player_deploy = player addaction[("<t color=""#007ab7"">" + ("Pack transport") +"</t>"),"scripts\spawnbike\init.sqf",["pack",_thing],5,false,true,"", ""];
		};
	} else {
		
		player removeAction s_player_deploy;
		s_player_deploy = -1;
	};
========== spawn vehicle end ===================
};
	~~~~

1. That allows players to repack the deployables.
2. Now you need to change the filepath for your deploy activation to point to the menu.sqf
	#### If you use something like clickactions to add right click to toolbox then;

1. Open the config file and edit to;
	~~~~java
If(DeployBikeScript)then{
	DEPLOY_BIKE = [
		["ItemToolbox","Deploy Vehicle","closeDialog 0;[] execVM '<path to spawnbike>\menu.sqf';","true"]
	];
} else {
	DEPLOY_BIKE = [];
};
	~~~~
1. Last, but not least, get rid of all the playeraction variables in your variables.sqf.  I had player 2's version of the spawn bike so replaced;

	~~~~java
	s_player_deploybike1 = -1;
	s_player_deploybike2 = -1;
	s_player_deploybike3 = -1;
	s_player_deploybike4 = -1;
	s_player_deploybike5 = -1;
	s_player_deploybike6 = -1;

  with simply;

s_player_deploy = -1;
  ~~~~
