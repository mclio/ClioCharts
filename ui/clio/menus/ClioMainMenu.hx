package ui.clio.menus;

import flixel.FlxG;

class ClioMainMenu extends ClioTextMenuState {
	public function create() {
		if (FlxG.sound.music != null) {
			FlxG.sound.music.stop();
			FlxG.sound.music.destroy();
			FlxG.sound.music = null;
		}

		addItem('charts', null);
		addItem('options', onOptions);
		addItem('credits', null);

		super.create();
	}

	function onCharts() {}
	function onOptions() {}
	function onCredits() {}
}
