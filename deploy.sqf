private ["_nearWalls","_plain","_item","_parts"];
_plain = _this select 0;
_item = _this select 1;
_cnt = 0;
if (count _this ==3) then {_parts = _this select 2;_cnt = count _parts;};
if(_plain =="Pack") then {
	_cnt = ["Old_bike_TK_CIV_EP1","TT650_Civ","CSJ_GyroC"] find _item;
	switch (_cnt) do {
	case 0: { _parts = [];};
	case 1: { _parts = ["PartEngine","PartGeneric"];};
	case 2: { _parts = ["PartEngine","PartGeneric","PartGeneric","PartVRotor"];};
	};
	if (dayz_combat == 1) then { 
		cutText [format["You are in Combat and cannot Re-Pack your vehicle"], "PLAIN DOWN"];
	} else {
		player playActionNow "Medic";
		r_interrupt = false;
		_targetBike = nearestObjects [player, [_item], 5];
		deleteVehicle (_targetBike select 0);
		_dis=10;
		_sfx = "repair";
		[player,_sfx,0,false,_dis] call dayz_zombieSpeak;
		[player,_dis,true,(getPos player)] spawn player_alertZombies;
		sleep 6;
		_bp = unitBackpack player;// get backpack from the player
		if (_cnt >0) then {
			if (isNull _bp) then {
				_pos = getposASL player;
				_object = "WeaponHolder" createVehicle getpos player;
				{_object addMagazinecargo [_x, 1];} count _parts;
				_object setPosASL _pos;
				cutText [format["You have packed your vehicle and the parts have been dropped on the ground."], "PLAIN DOWN"];
			} else {
				{_bp addMagazineCargoGlobal [_x, 1];} count _parts;
				cutText [format["You have packed your vehicle and the parts are in your backpack."], "PLAIN DOWN"];
			};
		} else {
			cutText [format["You have packed your bike and reclaimed your toolbox."], "PLAIN DOWN"];
		};
		player addWeapon "ItemToolbox";
		r_interrupt = false;
		player switchMove "";
		player playActionNow "stop";	
	};
}else{
	if (dayz_combat == 1) exitWith {cutText[format["You are in Combat and cannot deploy a %1.", _plain], "PLAIN DOWN"];};
	_nearWalls = nearestObjects [player, ["Plastic_Pole_EP1_DZ"], 20];
	if (count _nearWalls > 0) then {
		cutText [format["\n\nYou are too close to a base!"], "PLAIN DOWN"];
	} else {
		player playActionNow "Medic";
		r_interrupt = false;
		player removeWeapon "ItemToolbox";
		if (_cnt >0) then {{player removeMagazine _x;} count _parts;};
		_dis=10;
		_sfx = "repair";
		[player,_sfx,0,false,_dis] call dayz_zombieSpeak;
		[player,_dis,true,(getPos player)] spawn player_alertZombies;
		sleep 6;
		_object = _item createVehicle (position player);
		_object setVariable ["ObjectID", "1", true];
		_object setVariable ["ObjectUID", "1", true];
		_object attachto [player,[0.0,3.0,2]];
		sleep 3;
		detach _object;
		player reveal _object;
		cutText [format["You've used your parts to deploy a %1.",_plain], "PLAIN DOWN"];
		r_interrupt = false;
		player switchMove "";
		player playActionNow "stop";
		sleep 10;
		cutText [format["Warning: Deployed %1s DO NOT SAVE after server restart!",_plain], "PLAIN DOWN"];
	};
};
