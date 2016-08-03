package
{
	import away3d.cameras.Camera3D;
	import away3d.cameras.lenses.LensBase;
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.controllers.HoverController;
	import away3d.core.base.Object3D;
	import away3d.core.managers.Stage3DManager;
	import away3d.core.managers.Stage3DProxy;
	import away3d.core.math.MathConsts;
	import away3d.core.render.RendererBase;
	import away3d.entities.Mesh;
	import away3d.events.AssetEvent;
	import away3d.events.LoaderEvent;
	import away3d.events.Stage3DEvent;
	import away3d.library.AssetLibrary;
	import away3d.library.assets.AssetType;
	import away3d.loaders.Loader3D;
	import away3d.loaders.parsers.OBJParser;
	import away3d.loaders.parsers.Parsers;
	import away3d.materials.MaterialBase;
	import away3d.materials.TextureMaterial;
	import away3d.textures.BitmapTexture;
	
	import content.ContentType;
	import content.dataProvider.IContentDataProvider;
	import content.dataProvider.states.ContentDataStatesFactory;
	import content.dataProvider.states.IContentDataStatesFactory;
	import content.factories.ContentDataFactory;
	import content.factories.ContentViewsFactory;
	import content.factories.IContentDataFactory;
	import content.factories.IContentViewsFactory;
	import content.view.Model3DContentView;
	import content.view.states.ContentViewStatesFactory;
	import content.view.states.IContentViewStatesFactory;
	
	import events.ApplicationEvent;
	import events.ModelEvent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display3D.textures.Texture;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	import flash.net.SharedObject;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.engine.RenderingMode;
	
	import org.gestouch.core.Gestouch;
	import org.gestouch.extensions.starling.StarlingDisplayListAdapter;
	import org.gestouch.extensions.starling.StarlingTouchHitTester;
	import org.gestouch.input.NativeInputAdapter;
	
	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;
	
	import states.ApplicationStatesFactory;
	import states.IApplicationState;
	
	[SWF(width="768", height="1024", frameRate="60", backgroundColor="#ffffff")]
	
	public class Application extends flash.display.Sprite
	{	
		private var _state:IApplicationState;
		
		private var _eventBroadcaster:EventBroadcaster;
		private var _model:ApplicationModel;
		
		//Away3D 
		private var _stage3DManager	:Stage3DManager;
		private var _stage3DProxy	:Stage3DProxy;		
		
		//Starling 
		private var _starling			:Starling;
		private var _starlingMediator	:StarlingMediator;
		
		private var _sharedObject:SharedObject;
		
		public function Application()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;				
			
			_eventBroadcaster = new EventBroadcaster();
			_eventBroadcaster.addEventListener(ModelEvent.DATA_LOAD_COMPLETE, dataLoadCompleteHandler);
			_eventBroadcaster.addEventListener(ApplicationEvent.DISPLAY_3D, display3DHandler);
			_eventBroadcaster.addEventListener(ApplicationEvent.DISPLAY_TEXT, displayTextHandler);
			_eventBroadcaster.addEventListener(ApplicationEvent.DISPLAY_IMAGE, displayImageHandler);
			_eventBroadcaster.addEventListener(ApplicationEvent.DISPLAY_PDF, displayPdfHandler);
			_eventBroadcaster.addEventListener(ApplicationEvent.DISPLAY_VIDEO, displayVideoHandler);
			_eventBroadcaster.addEventListener(ApplicationEvent.CONTENT_LOAD_MODE_CHANGE, contentLoadModeChangeHandler);
			
			var contentDataFactory:IContentDataFactory = new ContentDataFactory(_eventBroadcaster);
			var contentDataStatesFactory:IContentDataStatesFactory = new ContentDataStatesFactory();
			var contentViesStatesFactory:IContentViewStatesFactory = new ContentViewStatesFactory();
			var contentViewsFactory:IContentViewsFactory = new ContentViewsFactory(_eventBroadcaster, contentViesStatesFactory);
			_model = new ApplicationModel(_eventBroadcaster, contentDataFactory, contentDataStatesFactory, contentViewsFactory);
						
			var applicationStatesFactory:ApplicationStatesFactory = new ApplicationStatesFactory(this);	
			applyState(applicationStatesFactory.getStateLoadingData());
		}
		
		public function applyState(newState:IApplicationState):void
		{
			if (_state)
			{
				_state.exit();
				_state = null;
			}
			
			_state = newState;
			_state.entry();			
		}
		
		//application specific methods
		public function loadData():void
		{
			_model.loadData();
		}		
				
		public function startInitialization():void
		{
			_stage3DManager = Stage3DManager.getInstance(stage);
			_stage3DProxy = _stage3DManager.getFreeStage3DProxy();
			_stage3DProxy.addEventListener(Stage3DEvent.CONTEXT3D_CREATED, context3DCreatedHandler);
			_stage3DProxy.antiAlias = 8;
			_stage3DProxy.color = 0xcccccc;
		}
		
		protected function context3DCreatedHandler(event:flash.events.Event=null):void
		{				
			initStarling();
		}		
		
		private function initStarling():void
		{					
			Starling.multitouchEnabled = true;			
			_starling = new Starling(StarlingView, stage, _stage3DProxy.viewPort, _stage3DProxy.stage3D);
			_starling.shareContext = true;
			_starling.start();
			_starling.addEventListener(starling.events.Event.ROOT_CREATED, starlingRootCreatedHandler);		
		}					
		
		private function starlingRootCreatedHandler(event:starling.events.Event):void
		{			
			initContent();	
			addContent();
			
			_starlingMediator = new StarlingMediator(_starling.root as StarlingView, _model, _eventBroadcaster);
			_state.initializationComplete();
		}		
		
		private function initContent():void
		{
			_model.setupContentLoadingStrategy(_model.getLoadingMode());
			_model.initContentDataProviders();
			_model.initContentDataProviderStates();
			_model.initContentViews();			
		}
		
		private function addContent():void
		{			
			(_starling.root as StarlingView).addChild(_model.getContentViewByType(ContentType.TEXT) as starling.display.Sprite);
			(_starling.root as StarlingView).addChild(_model.getContentViewByType(ContentType.IMAGE) as starling.display.Sprite);
			(_starling.root as StarlingView).addChild(_model.getContentViewByType(ContentType.VIDEO) as starling.display.Sprite);
			
			var model3DView:Model3DContentView = _model.getContentViewByType(ContentType.MODEL3D) as Model3DContentView;
			model3DView.setupStages(stage, _stage3DProxy);
			addChild(model3DView.view3D);
		}
		
		public function displayContentByType(type:uint):void
		{			
			_eventBroadcaster.dispatchEvent(ModelEvent.DISPLAY_CONTENT, _model.getContentDataByType(type));
		}
		
		public function hideContentByType(type:uint):void
		{			
			_eventBroadcaster.dispatchEvent(ModelEvent.HIDE_CONTENT, _model.getContentDataByType(type));
		}
		
		public function hideAllContent():void
		{
			for (var i:int=0; i<_model.contentItemsNumber; i++)
			{				
				_eventBroadcaster.dispatchEvent(ModelEvent.HIDE_CONTENT, _model.getContentDataByType(i));
			}
		}
		
		public function startRendering():void
		{
			_stage3DProxy.addEventListener(flash.events.Event.ENTER_FRAME, onEnterFrame);
		}
		
		public function renderStarling():void
		{
			_starling.nextFrame();
		}
		
		//state specific methods		
		private function dataLoadCompleteHandler():void
		{
			_state.dataLoadComplete();
		}
		
		private function onEnterFrame(event:flash.events.Event):void
		{
			_state.render();
		}
		
		private function display3DHandler():void
		{
			_state.display3D();
		}
		
		private function displayTextHandler():void
		{
			_state.displayText();
		}
		
		private function displayImageHandler():void
		{
			_state.displayImage();
		}
		
		private function displayPdfHandler():void
		{
			_state.displayPdf();
		}
		
		private function displayVideoHandler():void
		{
			_state.displayVideo();
		}
		
		private function contentLoadModeChangeHandler(mode:Boolean):void
		{
			_model.setLoadingMode(mode);
			_model.setupContentLoadingStrategy(mode);
		}
	}
}