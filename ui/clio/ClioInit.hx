package ui.clio;

import funkin.modding.module.Module;
import funkin.InitState;
import funkin.data.quickpanel.PanelRegistry;
import funkin.ui.quickpanel.PanelEntry;
import ui.clio.menus.ClioMainMenu;
import flixel.FlxG;
import flixel.input.keyboard.FlxKey;
import funkin.util.InputUtil;

class ClioInit extends Module {
	override public function new() {
		super('clio-title');
	}

	public function onCreate() {
		var CMM = new ClioMainMenu();

		InitState.customTitleState = function() return CMM;
		InitState.customTitleStateAssetsQuery = function(type) return CMM.queryAssets(type);

		var wanted = ['crashlog', 'mods', 'exit-mod'];

		// AWE
		if (InputUtil.allPressed([FlxKey.A, FlxKey.W, FlxKey.E,])) {
			wanted.insert(0, 'chartEditor');
			wanted.insert(1, 'cameraEditor');
		}

		@:privateAccess
		for (entry => what in PanelRegistry.instance.entries) {
			if (!wanted.contains(entry))
				continue;
			if (PanelRegistry.instance.entries.exists('clio-$entry'))
				continue;

			trace(entry, what);

			var newEntry = new PanelEntry(entry);
			newEntry._data.panel = 'clio';
			newEntry._data.order = wanted.indexOf(entry);
			PanelRegistry.instance.entries.set('clio-$entry', newEntry);
		}

		trace(PanelRegistry.instance.listPanelEntries('clio'));
	}
}
