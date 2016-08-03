package content.view
{
	import away3d.cameras.Camera3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.controllers.HoverController;
	import away3d.core.managers.Stage3DProxy;
	import away3d.entities.Mesh;
	import away3d.events.AssetEvent;
	import away3d.events.LoaderEvent;
	import away3d.library.assets.AssetType;
	import away3d.loaders.Loader3D;
	import away3d.loaders.parsers.Parsers;
	import away3d.materials.TextureMaterial;
	
	import content.ContentType;
	import content.view.states.IContentViewState;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.geom.Vector3D;
	import flash.net.URLRequest;

	public class Model3DContentView extends BaseNon2DContentView implements IContentView
	{		
		private var _stage			:Stage;
		private var _stage3DProxy	:Stage3DProxy;
		
		private var _scene3D		:Scene3D;
		private var _view3D			:View3D;
		private var _camera3D		:Camera3D;			
		private var _hoverController:HoverController;		
		private var _loader3D		:Loader3D;
		private var _zOffset		:int=1;
		
		public function Model3DContentView()
		{
			super();
				
		}
		
		public function setupStages(stage:Stage, stage3DProxy:Stage3DProxy):void
		{
			_stage = stage;
			_stage3DProxy = stage3DProxy;		
			
			_scene3D = new Scene3D();
			_camera3D = new Camera3D();
			_camera3D.lookAt(new Vector3D(0, 0, 0));
			
			_view3D = new View3D(_scene3D, _camera3D);  
			_view3D.stage3DProxy = _stage3DProxy;
			_view3D.shareContext = true;
			
			_stage.addChild(_view3D);			
			Parsers.enableAllBundled();
		}
		
		public function get view3D():View3D
		{
			return _view3D;
		}
		
		override public function getType():uint
		{			
			return ContentType.MODEL3D;
		}
		
		override public function startRender():void
		{
			_view3D.scene.addChild(_loader3D);
			_stage3DProxy.addEventListener(flash.events.Event.ENTER_FRAME, onEnterFrame);
		}
		
		override public function stopRender():void
		{
			if (!_stage3DProxy) return;
			
			_stage3DProxy.removeEventListener(flash.events.Event.ENTER_FRAME, onEnterFrame);
			_view3D.scene.removeChild(_loader3D);
		}
		
		private function onEnterFrame(event:Event):void
		{
			_loader3D.rotationY = _stage.mouseX - _stage.stageWidth/2;
			_view3D.camera.y = 3 * (_stage.mouseY - _stage.stageHeight/2);
			_view3D.camera.lookAt(_loader3D.position);
			
			_view3D.render();	
		}
		
		override public function saveData(data:*):void
		{
			super.saveData(data);
			
			_loader3D = new Loader3D();
			_loader3D.addEventListener(LoaderEvent.RESOURCE_COMPLETE, resourceCompleteHandler);
			_loader3D.addEventListener(LoaderEvent.LOAD_ERROR, onLoadError);		
			_loader3D.addEventListener(AssetEvent.ASSET_COMPLETE, assetCompleteHandler);
			_loader3D.load(new URLRequest(_data));
		}
		
		private function onLoadError(event: LoaderEvent) : void
		{
			//trace(event.message);
		}
		
		private function resourceCompleteHandler(event:LoaderEvent):void
		{
			_loader3D.removeEventListener(LoaderEvent.LOAD_ERROR, onLoadError);		
			_loader3D.removeEventListener(AssetEvent.ASSET_COMPLETE, assetCompleteHandler);
			_loader3D.removeEventListener(LoaderEvent.RESOURCE_COMPLETE, resourceCompleteHandler);			
			_zOffset = 1;
					
			adjustModelView(_loader3D);				
		}
		
		protected function assetCompleteHandler(event:AssetEvent):void
		{ 
			//trace(event.asset.assetType);
			
			if (event.asset.assetType == AssetType.MESH)
			{
				var mesh:Mesh = event.asset as Mesh;
				
				if (mesh.material is TextureMaterial)
				{
					(mesh.material as TextureMaterial).alphaBlending = true;
					(mesh.material as TextureMaterial).alpha = .5;		
					(mesh.material as TextureMaterial).bothSides = true;
					
					mesh.zOffset = _zOffset;
					_zOffset++;
				}
			}
		}
		
		private function adjustModelView(loader3D:Loader3D):void
		{
			var modelWidth:Number = loader3D.maxX - loader3D.minX;
			var screenBordersOffset:uint = 50;
			loader3D.scale(Math.round(((_stage.stageWidth - screenBordersOffset)/modelWidth * 100))/100);
			loader3D.x = (_stage.stageWidth - modelWidth)/2;
		}	
	}
}