package ui.clio.menus;

import funkin.assets.Assets;
import funkin.assets.Paths;
import funkin.audio.FunkinSound;
import flixel.text.FlxText;
import flixel.group.FlxSpriteContainer;
import flixel.FlxG;
import flixel.FlxObject;
import funkin.ui.MusicBeatState;

class ClioTextMenuState extends MusicBeatState {
	final FONT_Ac437_CompaqThin_8x16:String = 'ui/clio/Ac437_CompaqThin_8x16';

	final SOUND_CANCELMENU = 'ui/clio/menus/sounds/cancel-menu';
	final SOUND_SCROLLMENU = 'ui/clio/menus/sounds/scroll-menu';
	final SOUND_SELECTMENU = 'ui/clio/menus/sounds/select-menu';

	public function queryAssets(type:AssetType):Array<AssetPath> {
		switch (type) {
			case 'FONT':
				return [Paths.font(FONT_Ac437_CompaqThin_8x16),];

			case 'SOUND':
				function sfx(sound)
					return Path.sound(sound).audio();

				return [sfx(SOUND_CANCELMENU), sfx(SOUND_SCROLLMENU), sfx(SOUND_SELECTMENU),];

			default:
		}

		return [];
	}

	var items:Array<String> = [];
	var itemsTexts:FlxSpriteContainer;

	var camFollow:FlxObject;

	var selected = 0;

	public function create() {
		super.create();

		add(camFollow = new FlxObject(FlxG.width / 2, 0, 1, 1));
		add(itemsTexts = new FlxSpriteContainer());

		final tsize = 32;
		for (i => item in items) {
			var itemText = new FlxText(0, 20 + (i * (tsize * 2)), camera.width, item.toUpperCase(), tsize);
			itemsTexts.add(itemText);

			itemText.setFormat(Paths.font(FONT_Ac437_CompaqThin_8x16), tsize, 0xFFFFFFFF, 'center');
			itemText.ID = i;
		}

		resetCamStuff();
		move(0);
	}

	function resetCamStuff(snap:Bool = true):Void {
		FlxG.camera.follow(camFollow, null, 0.04);

		if (snap)
			FlxG.camera.snapToTarget();
	}

	function move(change = 0) {
		selected += change;

		if (selected < 0)
			selected = items.length - 1;
		if (selected > items.length - 1)
			selected = 0;

		FunkinSound.playOnce(Paths.sound(SOUND_SCROLLMENU).toFlxSoundAsset());

		for (itemText in itemsTexts) {
			itemText.color = (selected == itemText.ID) ? 0xFFFFFF00 : 0xFFFFFFFF;

			if (selected == itemText.ID)
				camFollow.y = itemText.y;
		}
	}

	override function update(elapsed) {
		super.update(elapsed);

		if (controls.UI_UP_P)
			move(-1);
		if (controls.UI_DOWN_P)
			move(1);
		if (controls.ACCEPT_P)
			select();
	}

	function select() {
		trace(items[selected]);

		FunkinSound.playOnce(Paths.sound(SOUND_SELECTMENU).toFlxSoundAsset());
	}
}
