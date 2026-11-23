package ui.clio.menus;

import funkin.assets.Assets;
import funkin.assets.Paths;
import funkin.audio.FunkinSound;
import flixel.text.FlxText;
import flixel.group.FlxSpriteContainer;
import flixel.FlxG;
import flixel.FlxObject;
import funkin.ui.MusicBeatState;
import funkin.util.Constants;
import funkin.graphics.FunkinCamera;

using StringTools;

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
				return [
					Paths.file(SOUND_CANCELMENU, Constants.EXT_SOUND),
					Paths.file(SOUND_SCROLLMENU, Constants.EXT_SOUND),
					Paths.file(SOUND_SELECTMENU, Constants.EXT_SOUND),
				];

			default:
		}

		return [];
	}

	var items:Array<String> = [];
	var itemsOnSelect:Array<Void->Void> = [];
	var itemsTexts:FlxSpriteContainer;

	var camFollow:FlxObject;

	var selected = 0;

	public function create() {
		super.create();

		FlxG.cameras.reset(new FunkinCamera('menuCam'));
		add(camFollow = new FlxObject(FlxG.width / 2, 0, 1, 1));
		add(itemsTexts = new FlxSpriteContainer());

		final tsize = 32;
		var skip = 0;
		for (i => item in items) {
			if (item == null || item?.trim()?.length < 0) {
				skip++;
				continue;
			}

			var itemText = new FlxText(0, 20 + (i * (tsize * 2)), camera.width, item.toUpperCase(), tsize);
			itemsTexts.add(itemText);

			itemText.setFormat(Paths.font(FONT_Ac437_CompaqThin_8x16), tsize, 0xFFFFFFFF, 'center');
			itemText.ID = i - skip;
		}

		FlxG.camera.follow(camFollow, null, 0.04);
		FlxG.camera.snapToTarget();

		move(0);

		#if FEATURE_DEBUG_MENU
		funkin.util.plugins.SidePanelPlugin.requestPanel('clio', true);
		#end
	}

	function move(change = 0) {
		selected += change;

		if (selected < 0)
			selected = itemsTexts.members.length - 1;
		if (selected > itemsTexts.members.length - 1)
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
		var selection = itemsOnSelect[selected];

		FunkinSound.playOnce(Paths.sound(SOUND_SELECTMENU).toFlxSoundAsset());

		if (selection != null)
			selection();
	}

	function addItem(?item:String, ?onSelect:Void->Void) {
		items.push(item ?? null);
		itemsOnSelect.push(onSelect ?? null);
	}
}
