package content.view
{
	import content.ContentType;
	import content.view.states.IContentViewStatesFactory;
	
	import feathers.controls.ImageLoader;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class ImageContentView extends Base2DContentView
	{
		private var _imageLoader:ImageLoader;
		
		public function ImageContentView()
		{
			super();
		}
		
		override public function init():void
		{
			super.init();
			
			_imageLoader = new ImageLoader();
			addChild(_imageLoader);
		}
		
		override protected function onAddedToStage(event:Event=null):void
		{
			super.onAddedToStage(event);
			_imageLoader.width = stage.stageWidth;
			_imageLoader.height = stage.stageHeight;
			_imageLoader.scaleContent = true;
		}
				
		override public function saveData(data:*):void
		{
			super.saveData(data);			
			_imageLoader.source = _data;			
		}
		
		override public function getType():uint
		{			
			return ContentType.IMAGE;
		}
	}
}