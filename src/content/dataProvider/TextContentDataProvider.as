package content.dataProvider
{
	import content.ContentType;
	import content.dataProvider.states.IContentDataStatesFactory;
	
	public class TextContentDataProvider extends BaseContentDataProvider
	{
		public function TextContentDataProvider(data:Object, eventBroadcaster:EventBroadcaster)
		{
			super(data, eventBroadcaster);
		}
		
		override public function getSource():*
		{
			return _data.text;
		}	
		
		override public function checkContentOffline():Boolean
		{
			return true;
		}
		
		
		override public function loadContent():void
		{
			_state.loadComplete();
		}
		
		override public function getType():uint
		{
			return ContentType.TEXT;
		}
	}
}