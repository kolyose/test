package
{
	import content.ContentType;
	import content.dataProvider.IContentDataProvider;
	import content.factories.IContentViewsFactory;
	import content.view.Base2DContentView;
	import content.view.IContentView;
	import content.view.states.ContentViewStatesFactory;
	import content.view.states.IContentViewStatesFactory;
	
	import events.ViewEvent;
	
	import feathers.controls.Button;
	import feathers.controls.Check;
	import feathers.controls.Header;
	import feathers.controls.List;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.controls.text.TextBlockTextRenderer;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.FeathersControl;
	import feathers.core.ITextRenderer;
	import feathers.data.ListCollection;
	import feathers.skins.AddOnFunctionStyleProvider;
	
	import flash.text.engine.CFFHinting;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontDescription;
	import flash.text.engine.FontLookup;
	import flash.text.engine.FontPosture;
	import flash.text.engine.FontWeight;
	import flash.text.engine.RenderingMode;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.textures.Texture;
	
	public class StarlingView extends Sprite
	{
		private var _eventBroadcaster:EventBroadcaster;
		
		private var _header:Header;
		private var _menuList:List;
		
		public function StarlingView()
		{
		}		
		
		public function initHeader(menuData:Array, loadingMode:Boolean):void
		{			
			_header = new Header();
			_header.width = stage.stageWidth;
			_header.height = 100;
			_header.backgroundSkin = new Image(Texture.fromBitmap(new Assets.headerBg()));
			addChild(_header);
			
			var btnClose:Button = new Button();
			btnClose.defaultSkin = new Image(Texture.fromBitmap(new Assets.close()));
			btnClose.addEventListener(Event.TRIGGERED, btnCloseTriggeredHandler);
			_header.leftItems = new <DisplayObject>[btnClose];
			
			var cbContentLoadMode:Check = new Check();
			var cbTexture:Texture = Texture.fromBitmap(new Assets.offline());		
			cbContentLoadMode.isSelected = !loadingMode;
			updateCheckLabel(cbContentLoadMode);			
			cbContentLoadMode.defaultIcon = new Image(cbTexture);
			cbContentLoadMode.defaultSelectedIcon = new Image(Texture.fromBitmap(new Assets.online()));
			cbContentLoadMode.addEventListener(Event.CHANGE, cbContentLoadModeChangeHandler);
			cbContentLoadMode.paddingRight = 10;
			
			var btnMenu:Button = new Button();
			var menuTexture:Texture = Texture.fromBitmap(new Assets.menu());
			btnMenu.defaultSkin = new Image(menuTexture);
			btnMenu.addEventListener(Event.TRIGGERED, btnMenuTriggeredHandler);
			_header.rightItems = new <DisplayObject>[cbContentLoadMode, btnMenu];
			
			_menuList = new List();
			_menuList.width = stage.stageWidth;
			_menuList.height = 300;
			addChild(_menuList);
			_menuList.visible = false;
			_menuList.addEventListener(Event.CHANGE, menuListChangeHandler);
					
			_menuList.dataProvider = new ListCollection(menuData);	
			
			FeathersControl.defaultTextRendererFactory = function():ITextRenderer
			{
				return new TextBlockTextRenderer();
			}				
			
			_menuList.itemRendererFactory = function():IListItemRenderer
			{
				var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
				renderer.labelField = "type";
				renderer.styleProvider = new AddOnFunctionStyleProvider(renderer.styleProvider, setItemRendererStyle);
				renderer.defaultSkin = new Image(Texture.fromBitmap(new Assets.menuItemBg()));
				return renderer;
			};
		}
				
		private function setItemRendererStyle(renderer:DefaultListItemRenderer):void
		{
			var fontDescription:FontDescription = new FontDescription("Arial", FontWeight.BOLD, FontPosture.NORMAL, FontLookup.DEVICE);
			renderer.defaultLabelProperties.elementFormat = new ElementFormat(fontDescription, 16,0x000000);
		}
		
		private function cbContentLoadModeChangeHandler(event:Event):void
		{
			var cbContentLoadMode:Check = event.currentTarget as Check;
			updateCheckLabel(cbContentLoadMode);			
			dispatchEventWith(ViewEvent.CONTENT_LOAD_MODE_CHANGE, false, !cbContentLoadMode.isSelected);
		}
		
		private function updateCheckLabel(check:Check):void
		{
			if (check.isSelected)
				check.label = "online";
			else
				check.label = "offline";
		}
		
		private function btnCloseTriggeredHandler(event:Event):void
		{
			_menuList.selectedIndex = -1;
			dispatchEventWith(ViewEvent.MENU_ITEM_SELECT, false, _menuList.selectedIndex);
		}
		
		private function menuListChangeHandler(event:Event):void
		{
			hideMenu();
			dispatchEventWith(ViewEvent.MENU_ITEM_SELECT, false, _menuList.selectedIndex);
		}
		
		private function showMenu():void
		{
			_menuList.visible = true;
			_menuList.touchable = true;			
		}
		
		private function hideMenu():void
		{
			_menuList.visible = false;
			_menuList.touchable = false;		
		}
		
		private function btnMenuTriggeredHandler(event:Event):void
		{
			showMenu();
		}
	}
}