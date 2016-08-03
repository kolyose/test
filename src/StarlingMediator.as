package
{
	import content.ContentType;
	import content.dataProvider.IContentDataProvider;
	
	import events.ApplicationEvent;
	import events.ModelEvent;
	import events.ViewEvent;
	
	import starling.events.Event;
	import content.factories.IContentViewsFactory;

	public class StarlingMediator
	{
		private var _view				:StarlingView;
		private var _model				:ApplicationModel;
		private var _eventBroadcaster	:EventBroadcaster;
		
		public function StarlingMediator(view:StarlingView, model:ApplicationModel, eventBroadcaster:EventBroadcaster)
		{
			_model = model;
			
			_eventBroadcaster = eventBroadcaster;	
			
			_view = view;
			_view.addEventListener(ViewEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
			_view.addEventListener(ViewEvent.CONTENT_LOAD_MODE_CHANGE, contentLoadModeChangeHandler);
			_view.initHeader(_model.data.menu, _model.getLoadingMode());				
		}
		
		private function menuItemSelectHandler(event:Event, data:int):void
		{
			switch(data)
			{
				case -1:
				{
					_eventBroadcaster.dispatchEvent(ApplicationEvent.DISPLAY_3D);
					break;
				}
					
				case ContentType.TEXT:
				{
					_eventBroadcaster.dispatchEvent(ApplicationEvent.DISPLAY_TEXT);
					break;
				}
					
				case ContentType.IMAGE:
				{
					_eventBroadcaster.dispatchEvent(ApplicationEvent.DISPLAY_IMAGE);
					break;
				}
					
				case ContentType.PDF:
				{
					_eventBroadcaster.dispatchEvent(ApplicationEvent.DISPLAY_PDF);
					break;
				}
					
				case ContentType.VIDEO:
				{
					_eventBroadcaster.dispatchEvent(ApplicationEvent.DISPLAY_VIDEO);
					break;
				}
				
				default:
					break;
			}
		}
		
		private function contentLoadModeChangeHandler(event:Event):void
		{
			_eventBroadcaster.dispatchEvent(ApplicationEvent.CONTENT_LOAD_MODE_CHANGE, event.data);
		}
		
	}
}