waitUntil {!(isNull (findDisplay 46))};
disableSerialization;

_rscLayer = "statusBar" call BIS_fnc_rscLayer;
_rscLayer cutRsc["statusBar","PLAIN"];
systemChat format["*Welcome message* %1!", _rscLayer];

[] spawn {
	sleep 5;
	_statusText = "Welcome";
	_counter = 180;
	_timeSinceLastUpdate = 0;
	while {true} do
	{
		sleep 1;
		_counter = _counter - 1;
		_statusText = "lifeisjoke.com";
		((uiNamespace getVariable "statusBar")displayCtrl 1000)ctrlSetText format["%5 | FPS: %1 | Spieler Online : %2 | TS3 : *to do* | Bargeld: %3 |", round diag_fps, count playableUnits, life_cash, _statusText, _counter];
	};
};
