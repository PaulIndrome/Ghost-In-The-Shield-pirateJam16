global.floods = [];

function floods_regenerate(){
	global.floods[0] = new EnemyFlood([
		new EnemyWave([
			new EnemyGroup(obj_demon_blue, 3, 0.25),
			new EnemyGroup(obj_demon_red, 1, 0.25),
		]), // wave
		//new EnemyWave([
		//	//new EnemyGroup(obj_demon_blue, 1, 0.25),
		//	new EnemyGroup(obj_demon_red, 1, 0.25),
		//]) // wave
	]); // flood 

	//global.floods[1] = new EnemyFlood([
	//	new EnemyWave([
	//		new EnemyGroup(obj_demon_blue, 10, 0.25),
	//		new EnemyGroup(obj_demon_red, 2, 1),
	//	]) // wave
	//]); // flood 
}
