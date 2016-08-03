package content.dataProvider
{
	import content.ContentType;
	import content.dataProvider.states.IContentDataStatesFactory;
	
	public class ImageContentDataProvider extends BaseContentDataProvider
	{
		public function ImageContentDataProvider(data:Object, eventBroadcaster:EventBroadcaster)
		{
			super(data, eventBroadcaster);
		}
		
		override public function getType():uint
		{
			return ContentType.IMAGE;
		}
	}
}