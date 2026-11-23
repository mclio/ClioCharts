package ui.clio;

import flixel.util.typeLimit.NextState;
import funkin.ui.transition.Transition.TransitionType;
import funkin.ui.transition.Transition.FadeType;
import funkin.ui.transition.Transition;
import funkin.assets.Assets;
import funkin.assets.Paths;
import flixel.FlxState;

typedef ClioUtilTransitionParams = {
	var ?transition:TransitionType;
	var ?assetQuery:AssetType->Array<AssetPath>;
	var ?priorityAssetQuery:AssetType->Array<AssetPath>;
	var ?shouldPurgeCache:Null<Bool>;
	var ?shouldStopMusic:Null<Bool>;
	var ?onConstruct:FlxState->Void;
}

class ClioUtil {
	public static function customTransition(state:NextState, ?params:ClioUtilTransitionParams) {
		Transition.switchState(state, {
			transition: params?.transition ?? TransitionType.None,
			assetQuery: params?.assetQuery ?? null,
			priorityAssetQuery: params?.priorityAssetQuery ?? null,
			shouldStopMusic: params?.shouldStopMusic ?? false,
			shouldPurgeCache: params?.shouldPurgeCache ?? true
		});
	}

	public static function snapTransition(state:NextState) {
		customTransition(state, null);
	}

	public static function trobberTransition(state:NextState, ?params:ClioUtilTransitionParams) {
		params ??= {};
		params.transition = TransitionType.Trobber;

		customTransition(state, params);
	}

	public static function blackScreenTransition(state:NextState, ?inFade:FadeType, ?outFade:FadeType, ?params:ClioUtilTransitionParams) {
		params ??= {};
		params.transition = TransitionType.BlackScreen(inFade ?? FadeType.None, outFade ?? FadeType.None);

		customTransition(state, params);
	}
}
