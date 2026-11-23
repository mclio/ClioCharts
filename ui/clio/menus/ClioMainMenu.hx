package ui.clio.menus;

import funkin.ui.MusicBeatState;
import funkin.assets.Assets;
import funkin.assets.Paths;
import flixel.text.FlxText;
import flixel.group.FlxSpriteContainer;
import flixel.FlxG;

class ClioMainMenu extends MusicBeatState {
	static var font:String = Paths.font('ui/clio/Ac437_CompaqThin_8x16');

	public static function queryAssets(type:AssetType):Array<AssetPath> {
		switch (type) {
			case 'FONT':
				return [ClioMainMenu.font,];

			default:
		}

		return [];
	}

	var items = ['charts', 'options', 'credits',];
	var itemsTexts:FlxSpriteContainer;

	public function create() {
		super.create();

		add(itemsTexts = new FlxSpriteContainer());

		final tsize = 32;
		for (i => item in items) {
			var itemText = new FlxText(0, 20 + (i * (tsize * 2)), camera.width, item.toUpperCase(), tsize);
			itemsTexts.add(itemText);

			itemText.setFormat(ClioMainMenu.font, tsize, 0xFFFFFFFF, 'center');
		}
	}
}
