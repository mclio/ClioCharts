package ui.clio;

import funkin.modding.module.Module;
import funkin.InitState;
import funkin.data.quickpanel.PanelRegistry;
import ui.clio.menus.ClioMainMenu;

class ClioInit extends Module {
	override public function new() {
		super('clio-title');
	}

	public function onCreate() {
		InitState.customTitleState = function() return new ClioMainMenu();
		InitState.customTitleStateAssetsQuery = function(type) return ClioMainMenu.queryAssets(type);
	}
}
