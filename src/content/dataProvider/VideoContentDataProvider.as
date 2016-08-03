package content.dataProvider
{
	import content.ContentType;
	import content.dataProvider.states.IContentDataStatesFactory;
	
	public class VideoContentDataProvider extends BaseContentDataProvider
	{
		public function VideoContentDataProvider(data:Object, eventBroadcaster:EventBroadcaster)
		{
			super(data, eventBroadcaster);
		}
		
		override public function getType():uint
		{
			return ContentType.VIDEO;
		}
	}
}