package ui.clio.menus;

import flixel.FlxG;

class ClioMainMenu extends ClioTextMenuState {
	public function create() {
		items = ['charts', 'options', 'credits',];

		super.create();

		if (FlxG.sound.music != null) {
			FlxG.sound.music.stop();
			FlxG.sound.music.destroy();
			FlxG.sound.music = null;
		}
	}
}
