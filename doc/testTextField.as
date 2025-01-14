package
{
	import com.greensock.BlitMask;
	import com.greensock.TweenLite;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author
	 */
	public class Main extends Sprite
	{
		private var content:Sprite;
		public function Main():void
		{
			if (stage)
				init1();
			else
				addEventListener(Event.ADDED_TO_STAGE, init1);
		}
		
		private function init1(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init1);
			// entry point
			content = new Sprite();
			setupContent();
			
			//setup BlitMask
			var bm:BlitMask = new BlitMask(content, content.x, content.y, 514, 350, false);
			content.addChild(bm);
			addChild(content);
			TweenLite.to(content, 60, {y: -3000, onUpdate: bm.update});
		
		}
		
		private function setupContent():void
		{
			//content.x = content.y = 18;
			//content.rotation = -6;
			
			var format:TextFormat = new TextFormat();
			format.font = "Times New Roman";
			format.size = 15;
			format.leading = 2;
			
			addChild(content);
			var text:String = "Blitting can significantly improve scrolling performance for large areas of text and/or images. To see the difference compared to normal mask and scrollRect techniques, select from the options below and click the TWEEN button. Then watch the frame rate. Blitting typically uses more memory but requires much less processing while scrolling/moving. BlitMask basically captures a bitmap version of the masked content and stores it in memory and then draws only the necessary pixels into the mask area and sets the 'visible' property of the original content to false, thus alleviating the Flash Player from having to worry about all those extra pixels. Maximum frame rate in this example is 60fps. For maximum performance, enable BlitMask's bitmapMode (like during animation) and then when you need interactivity, disable it. BlitMask even outperforms scrollRect with cacheAsBitmap set to true, and it also allows the content to be rotated, scaled, and smoothed (try that with scrollRect!). BlitMask is much easier to use too.";
			for (var i:int = 0; i < 14; i++)
			{
				var tf:TextField = new TextField();
				tf.text = text + "\n" + text + "\n" + text;
				tf.multiline = tf.wordWrap = true;
				tf.antiAliasType = "normal";
				tf.selectable = false;
				tf.textColor = 0x80FF00;
				tf.width = 370;
				tf.height = 1000;
				tf.setTextFormat(format);
				content.addChild(tf);
				tf.y = tf.height * (i - 2) + 5;
			}
		}
	}

}