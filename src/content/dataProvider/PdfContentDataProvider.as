package content.dataProvider
{
	import content.ContentType;
	import content.dataProvider.states.IContentDataStatesFactory;
	
	public class PdfContentDataProvider extends BaseContentDataProvider
	{
		public function PdfContentDataProvider(data:Object, eventBroadcaster:EventBroadcaster)
		{
			super(data, eventBroadcaster);
		}
		
		override public function getSource():*
		{
			load();
			return super.getSource();
		}	
		
		override public function getType():uint
		{
			return ContentType.PDF;
		}	
	}
}