package content.view
{
	import content.ContentType;
	import content.view.states.IContentViewStatesFactory;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.Color;
	
	public class TextContentView extends Base2DContentView
	{
		private var _tf:TextField;
		
		public function TextContentView()
		{
			super();
		}
		
		override protected function onAddedToStage(event:Event=null):void
		{
			super.onAddedToStage(event);
			
			_tf = new TextField(stage.stageWidth, stage.stageHeight, "");
			_tf.fontName = "Arial;"
			_tf.fontSize = 20;
			_tf.color = Color.BLACK;
			addChild(_tf);
		}
		
		override public function saveData(data:*):void
		{
			super.saveData(data);
			
			_tf.text = _data as String;		
		}
		
		override public function getType():uint
		{			
			return ContentType.TEXT;
		}
	}
}