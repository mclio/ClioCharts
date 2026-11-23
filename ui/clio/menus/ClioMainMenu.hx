package ui.clio.menus;

import flixel.FlxG;
import funkin.ui.transition.Transition.TransitionType;

class ClioMainMenu extends ClioTextMenuState {
	public function create() {
		if (FlxG.sound.music != null) {
			FlxG.sound.music.stop();
			FlxG.sound.music.destroy();
			FlxG.sound.music = null;
		}

		addItem('charts', onCharts);
		addItem('options', onOptions);
		addItem('credits', onCredits);

		super.create();
	}

	function onCharts() {}

	function onOptions() {}

	function onCredits() {
		var CCM = new ClioCreditsMenu();

		ClioUtil.snapTransition(CCM, {
			assetQuery: CCM.queryAssets,
		});
	}
}
