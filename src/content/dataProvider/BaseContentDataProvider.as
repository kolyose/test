package content.dataProvider
{
	
	import content.dataProvider.states.IContentDataState;
	import content.dataProvider.states.IContentDataStatesFactory;
	
	import events.ModelEvent;
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;

	public class BaseContentDataProvider implements IContentDataProvider
	{
		protected var _state:IContentDataState;
		protected var _eventBroadcaster:EventBroadcaster;		
		protected var _data:Object;
		
		public function BaseContentDataProvider(data:Object, eventBroadcaster:EventBroadcaster)
		{		
			_data = data;
			_eventBroadcaster = eventBroadcaster;
		}
		
		//state specific methods
		
		public function load():void
		{
			_state.load();
		}
		
		public function getSource():*
		{
			return _state.getSource();
		}		
		
		public function applyState(newState:IContentDataState):void
		{
			if (_state)
			{
				_state.exit();
				_state = null;
			}
			
			_state = newState;
			_state.entry();
		}		
			
		//app specific methods				
		public function loadContent():void
		{
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			var urlRequest:URLRequest = new URLRequest(getUrl());			
			urlLoader.addEventListener(Event.COMPLETE, contentLoadCompleteHandler);				
			urlLoader.load(urlRequest);
		}
		
		protected function contentLoadCompleteHandler(event:Event):void
		{
			var data:ByteArray = event.target.data;
			var fileStream:FileStream = new FileStream();				
			fileStream.open(getLocalFile(), FileMode.WRITE);
			fileStream.writeBytes(data, 0, data.length);
			fileStream.close();	
			
			_state.loadComplete();
		}
		
		public function checkContentOffline():Boolean
		{			
			return getLocalFile().exists;
		}
		
		public function notifyLoadComplete():void
		{
			_eventBroadcaster.dispatchEvent(ModelEvent.CONTENT_LOAD_COMPLETE, this);
		}
		
		public function getUrl():String
		{
			return _data.url;
		}
		
		public function getLocalFile():File
		{
			var splittedUrl:Array = String(_data.url).split("/"); 
			var filename:String = splittedUrl[splittedUrl.length-1]; 
			return File.applicationStorageDirectory.resolvePath(filename);
		}
		
		public function getLocalUrl():String
		{
			return getLocalFile().url;
		}
		
		public function getType():uint
		{
			return 0;
		}
	}
}