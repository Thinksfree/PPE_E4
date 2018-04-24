package buw;

import openfl.Assets;
import openfl.display.Bitmap;

class Image extends Widget {
	var bmp : Bitmap;
	var ratio : Float;

	/**
	 * @param imagePath the asset path
	 * @param relativeWidthOrHeight relative width if <= 1, height if > 1
	 * @throws String if relativeWidthOrHeight < 0
	 */
	public function new(imagePath : String, ?relativeWidthOrHeight : Float = 1) {
		super();
		bmp = new Bitmap(Assets.getBitmapData(imagePath));
		ratio =  bmp.width / bmp.height;
		addChild(bmp);
		if (relativeWidthOrHeight >= 0) {
			if (relativeWidthOrHeight <= 1) {
				this.relativeWidth = relativeWidthOrHeight;
			} else {
				bmp.height = relativeWidthOrHeight;
				bmp.width = bmp.height * ratio;
			}
		} else {
			throw "invalid relativeWidthOrHeight value: should be [0..+], given: " + Std.string(relativeWidthOrHeight);
		}
	}

	override function draw() {
		if (relativeWidth != 0) {
			bmp.width = getWidth();
			bmp.height = bmp.width / ratio;
		}
	}
}
