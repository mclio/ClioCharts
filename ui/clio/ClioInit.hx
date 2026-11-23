package ui.clio;

import funkin.modding.module.Module;
import funkin.InitState;
import funkin.data.quickpanel.PanelRegistry;
import funkin.ui.quickpanel.PanelEntry;
import ui.clio.menus.ClioMainMenu;

class ClioInit extends Module {
	override public function new() {
		super('clio-title');
	}

	public function onCreate() {
		var CMM = new ClioMainMenu();

		InitState.customTitleState = function() return CMM;
		InitState.customTitleStateAssetsQuery = function(type) return CMM.queryAssets(type);

		var wanted = ['crashlog', 'exit-mod', 'mods'];

		@:privateAccess
		for (entry => what in PanelRegistry.instance.entries) {
			if (!wanted.contains(entry)) continue;
			if (PanelRegistry.instance.entries.exists('clio-$entry')) continue;

			trace(entry, what);

			var newEntry = new PanelEntry(entry);
			newEntry._data.panel = 'clio';
			PanelRegistry.instance.entries.set('clio-$entry', newEntry);
		}

		trace(PanelRegistry.instance.listPanelEntries('clio'));
	}
}
