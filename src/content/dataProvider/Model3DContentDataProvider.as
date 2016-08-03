package content.dataProvider
{
	import away3d.loaders.Loader3D;
	
	import content.ContentType;
	import content.dataProvider.states.IContentDataStatesFactory;
	
	public class Model3DContentDataProvider extends BaseContentDataProvider
	{	
		public function Model3DContentDataProvider(data:Object, eventBroadcaster:EventBroadcaster)
		{
			super(data, eventBroadcaster);
		}		
		
		override public function getType():uint
		{
			return ContentType.MODEL3D;
		}
	}
}