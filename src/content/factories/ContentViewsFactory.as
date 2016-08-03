package content.factories
{
	import content.ContentType;
	import content.mediator.BaseContentMediator;
	import content.view.Base2DContentView;
	import content.view.IContentView;
	import content.view.ImageContentView;
	import content.view.Model3DContentView;
	import content.view.PdfContentView;
	import content.view.TextContentView;
	import content.view.VideoContentView;
	import content.view.states.ContentViewStatesFactory;
	import content.view.states.IContentViewStatesFactory;
	
	public class ContentViewsFactory implements IContentViewsFactory
	{
		private var _statesFactory:IContentViewStatesFactory;
		private var _eventBroadcaster:EventBroadcaster;
		
		public function ContentViewsFactory(eventBroadcaster:EventBroadcaster, statesFactory:IContentViewStatesFactory)
		{
			_eventBroadcaster = eventBroadcaster;
			_statesFactory = statesFactory;	
		}
		
		public function getViewByType(type:uint):IContentView
		{
			var view:IContentView;
			
			switch(type)
			{
				case ContentType.TEXT:
				{
					view = new BaseContentMediator(new TextContentView(), _statesFactory, _eventBroadcaster).view;
					break;
				}
					
				case ContentType.IMAGE:
				{
					view = new BaseContentMediator(new ImageContentView(), _statesFactory, _eventBroadcaster).view;
					break;
				}
					
				case ContentType.PDF:
				{
					view = new BaseContentMediator(new PdfContentView(), _statesFactory, _eventBroadcaster).view;
					break;
				}
					
				case ContentType.VIDEO:
				{
					view = new BaseContentMediator(new VideoContentView(), _statesFactory, _eventBroadcaster).view;
					break;
				}
					
				case ContentType.MODEL3D:
				{
					view = new BaseContentMediator(new Model3DContentView(), _statesFactory, _eventBroadcaster).view;
					break;
				}
				
				default:
					view = new Base2DContentView();
					break;
			}
			
			return view;
		}
	}
}