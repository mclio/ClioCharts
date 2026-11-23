package ui.clio.menus;

import funkin.modding.PolymodHandler;
import funkin.util.WindowUtil;

class ClioCreditsMenu extends ClioTextMenuState {
	public function create() {
		addItem('Back', onBack);
		addItem(null, null);
		for (entry in getCredits()) {
			addItem('${entry.name} - ${entry.role ?? 'N / A'}', (entry.url != null) ? () -> WindowUtil.openURL(entry.url) : null);
		}

		super.create();
	}

	function onBack() {
		var CMM = new ClioMainMenu();

		ClioUtil.snapTransition(CMM, {
			assetQuery: CMM.queryAssets,
		});
	}

	function getCredits() {
		var handler:Dynamic = PolymodHandler;
		var all:Array<Dynamic> = handler.getAllMods();
		for (mod in all) {
			if (mod.id != "cliocharts")
				continue;

			return mod.contributors;
		}
		return [];
	}
}
