package
{
	import away3d.entities.Mesh;
	import away3d.events.AssetEvent;
	import away3d.events.LoaderEvent;
	import away3d.library.assets.AssetType;
	import away3d.loaders.Loader3D;
	import away3d.materials.TextureMaterial;
	
	import content.ContentType;
	import content.dataProvider.BaseContentDataProvider;
	import content.dataProvider.IContentDataProvider;
	import content.dataProvider.states.ContentDataStatesFactory;
	import content.dataProvider.states.IContentDataStatesFactory;
	import content.factories.IContentDataFactory;
	import content.factories.IContentViewsFactory;
	import content.view.IContentView;
	
	import events.ModelEvent;
	
	import feathers.media.VideoPlayer;
	
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.events.OutputProgressEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.media.Video;
	import flash.net.FileReference;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.net.SharedObject;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import mx.core.mx_internal;
	
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	import starling.utils.SystemUtil;
	
	import strategies.ContentLoadingMode;
	import strategies.IContentLoadingStrategy;
	import strategies.OfflineLoadingStrategy;
	import strategies.OnlineLoadingStrategy;

	public class ApplicationModel
	{
		private var _eventBroadcaster			:EventBroadcaster;
		private var _data						:Object;
		private var _contentViewsByType			:Vector.<IContentView>;
		private var _contentDataProviderByType	:Vector.<IContentDataProvider>;
		private var _contentDataFactory			:IContentDataFactory;
		private var _contentDataStatesFactory	:IContentDataStatesFactory;
		private var _contentViewsFactory		:IContentViewsFactory;
		private var _contentLoadingStrategy		:IContentLoadingStrategy;
		private var _sharedObject				:SharedObject;
				
		public function ApplicationModel
			(
				eventBroadcaster			:EventBroadcaster, 
				contentDataFactory			:IContentDataFactory, 
				contentDataStatesFactory	:IContentDataStatesFactory,
				contentViewsFactory			:IContentViewsFactory
			)
		{
			
			_contentDataFactory = contentDataFactory;
			_contentDataStatesFactory = contentDataStatesFactory;
			_contentViewsFactory = contentViewsFactory;
			_eventBroadcaster = eventBroadcaster;			
		}
		
		public function loadData():void
		{
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, loadCompleteHandler);
			
			try
			{
				loader.load(new URLRequest("https://appdev.virtualviewing.co.uk/test/test.json"));
			}
			catch (error:Error)
			{
				trace(error.message);
			}
		}		
		
		private function loadCompleteHandler(event:Event):void
		{
			var loader:URLLoader = event.currentTarget as URLLoader;
			_data = JSON.parse(loader.data);			
			initContentDataProviders();
			loader.removeEventListener(Event.COMPLETE, loadCompleteHandler);
			loader = null;
			
			_eventBroadcaster.dispatchEvent(ModelEvent.DATA_LOAD_COMPLETE);
		}
		
		public function getLoadingMode():Boolean
		{
			_sharedObject = SharedObject.getLocal("local");
			if (_sharedObject && _sharedObject.data && _sharedObject.data["loadingMode"] != undefined)	
			{
				return Boolean(_sharedObject.data["loadingMode"]);
			}			
			
			return ContentLoadingMode.ONLINE;
		}		
		
		public function setLoadingMode(mode:Boolean):void
		{
			_sharedObject = SharedObject.getLocal("local");
			_sharedObject.data["loadingMode"] = mode;
			_sharedObject.flush();
		}		
		
		public function setupContentLoadingStrategy(mode:Boolean):void
		{
			switch (mode)
			{
				case ContentLoadingMode.ONLINE:
				{
					_contentLoadingStrategy = new OnlineLoadingStrategy();
					break;
				}
					
				case ContentLoadingMode.OFFLINE:
				{
					_contentLoadingStrategy = new OfflineLoadingStrategy();
					break;
				}
				
				default:
					_contentLoadingStrategy = new OfflineLoadingStrategy();
					break;
			}
		}
		
		public function initContentDataProviders():void
		{
			const LENGTH:uint = contentItemsNumber;			
			_contentDataProviderByType = new Vector.<IContentDataProvider>(LENGTH, true);
			for (var i:int=0; i<LENGTH-1; i++)
			{
				_contentDataProviderByType[i] = _contentDataFactory.getContentDataByType(i, _data.menu[i]);
			}			
			
			_contentDataProviderByType[ContentType.MODEL3D] = _contentDataFactory.getContentDataByType(ContentType.MODEL3D, _data.model3d);
		}			
		
		public function initContentDataProviderStates():void
		{
			for each (var provider:IContentDataProvider in _contentDataProviderByType)
			{				
				provider.applyState(_contentLoadingStrategy.getContentDataFirstState(provider, _contentDataStatesFactory));
			}
		}
		
		public function initContentViews():void
		{
			const LENGTH:uint = contentItemsNumber;			
			_contentViewsByType = new Vector.<IContentView>(LENGTH, true);	
			for (var i:int=0; i<LENGTH; i++)
			{
				_contentViewsByType[i] = _contentViewsFactory.getViewByType(i);
			}			
		}
		
		public function getContentDataByType(type:uint):IContentDataProvider
		{
			return _contentDataProviderByType[type];
		}
		
		public function getContentViewByType(type:uint):IContentView
		{
			return _contentViewsByType[type];
		}
		
		public function get contentItemsNumber():uint
		{
			return  _data.menu.length + 1;
		}
		
		public function get data():Object
		{
			return _data;
		}
	}
}