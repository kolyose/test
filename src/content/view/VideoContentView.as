package content.view
{
	import content.ContentType;
	import content.view.states.IContentViewStatesFactory;
	
	import feathers.controls.ImageLoader;
	import feathers.media.VideoPlayer;
	
	import starling.events.Event;
	
	public class VideoContentView extends Base2DContentView
	{
		private var _player:VideoPlayer;
		private var _imageLoader:ImageLoader;
		
		public function VideoContentView()
		{
			super();
		}
		
		override public function init():void
		{			
			super.init();
			
			_player = new VideoPlayer();			
			_imageLoader = new ImageLoader();	
			addChild(_player);
			_player.addChild(_imageLoader);
			_player.addEventListener(starling.events.Event.READY, videoPlayerReadyHandler);
		}
		
		private function videoPlayerReadyHandler(event:Event):void
		{
			_imageLoader.source = _player.texture;
			_imageLoader.width = stage.stageWidth;
			_imageLoader.height = stage.stageHeight;
			_imageLoader.scaleContent = true;
			//_imageLoader.textureScale = (_imageLoader.source.width > _imageLoader.source.height) ? stage.stageWidth/_imageLoader.source.width : stage.stageHeight/_imageLoader.source.height;			
		}
				
		override public function saveData(data:*):void
		{
			super.saveData(data);	
			_player.videoSource = _data;
		}
		
		override public function getType():uint
		{			
			return ContentType.VIDEO;
		}
	}
}