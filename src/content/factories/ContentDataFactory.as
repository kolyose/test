package content.factories
{
	import content.ContentType;
	import content.dataProvider.BaseContentDataProvider;
	import content.dataProvider.IContentDataProvider;
	import content.dataProvider.ImageContentDataProvider;
	import content.dataProvider.Model3DContentDataProvider;
	import content.dataProvider.PdfContentDataProvider;
	import content.dataProvider.TextContentDataProvider;
	import content.dataProvider.VideoContentDataProvider;
	import content.dataProvider.states.ContentDataStatesFactory;
	import content.dataProvider.states.IContentDataStatesFactory;
	
	import strategies.IContentLoadingStrategy;

	public class ContentDataFactory implements IContentDataFactory
	{
		private var _contentDataStatesFactory:IContentDataStatesFactory;
		private var _eventBroadcaster:EventBroadcaster;
		
		public function ContentDataFactory(eventBrodcaster:EventBroadcaster)
		{
			_eventBroadcaster = eventBrodcaster;
		}
		
		public function getContentDataByType(type:uint, data:Object):IContentDataProvider
		{
			var content:IContentDataProvider;
			
			switch(type)
			{
				case ContentType.TEXT:
				{
					content = new TextContentDataProvider(data, _eventBroadcaster);
					break;
				}
					
				case ContentType.IMAGE:
				{
					content = new ImageContentDataProvider(data, _eventBroadcaster);
					break;
				}
					
				case ContentType.PDF:
				{
					content = new PdfContentDataProvider(data, _eventBroadcaster);
					break;
				}
					
				case ContentType.VIDEO:
				{
					content = new VideoContentDataProvider(data, _eventBroadcaster);
					break;
				}
					
				case ContentType.MODEL3D:
				{
					content = new Model3DContentDataProvider(data, _eventBroadcaster);
					break;
				}					
					
				default:
					content = new BaseContentDataProvider(type, _eventBroadcaster);
					break;
			}
			
			return content;
		}
	}
}