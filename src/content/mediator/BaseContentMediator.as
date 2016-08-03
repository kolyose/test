package content.mediator
{
	import content.dataProvider.IContentDataProvider;
	import content.view.IContentView;
	import content.view.states.IContentViewStatesFactory;
	
	import events.ModelEvent;

	public class BaseContentMediator implements IContentMediator
	{
		protected var _view:IContentView;
		protected var _eventBroadcaster:EventBroadcaster;
		
		public function BaseContentMediator(view:IContentView, viewStatesFactory:IContentViewStatesFactory, eventBroadcaster:EventBroadcaster)
		{
			_view = view;			
			_view.applyState(viewStatesFactory.getStateInitital(_view));
			
			_eventBroadcaster = eventBroadcaster;		
			_eventBroadcaster.addEventListener(ModelEvent.CONTENT_LOAD_COMPLETE, contentLoadCompleteHandler);
			_eventBroadcaster.addEventListener(ModelEvent.DISPLAY_CONTENT, displayContentHandler);
			_eventBroadcaster.addEventListener(ModelEvent.HIDE_CONTENT, hideContentHandler);
		}
		
		private function contentLoadCompleteHandler(contentData:IContentDataProvider):void
		{
			if (contentData.getType() != _view.getType())
				return;
			
			var source:* = contentData.getSource();
			if (source == undefined || source == null)
				return;
			
			_view.setData(source);
		}
		
		private function displayContentHandler(contentData:IContentDataProvider):void
		{
			if (contentData.getType() != _view.getType())
				return;
			
			_view.display();	
			
			var source:* = contentData.getSource();
			if (source == undefined || source == null)
				return;
			
			_view.setData(source);
		}
		
		private function hideContentHandler(contentData:IContentDataProvider):void
		{
			if (contentData.getType() != _view.getType())
				return;
			
			_view.hide();
		}
		
		public function get view():IContentView
		{
			return _view;
		}
		
	}
}