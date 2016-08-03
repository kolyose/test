package content.dataProvider.states
{
	import content.dataProvider.IContentDataProvider;

	public class ContentDataStatesFactory implements IContentDataStatesFactory
	{
		public function ContentDataStatesFactory()
		{
			
		}
		
		public function getStateInitial(item:IContentDataProvider):IContentDataState
		{
			return new ContentDataStateInitial(item, this);
		}
		
		public function getStateLoading(item:IContentDataProvider):IContentDataState
		{
			return new ContentDataStateLoading(item, this);
		}
		
		public function getStateReadyOffline(item:IContentDataProvider):IContentDataState
		{
			return new ContentDataStateReadyOffline(item, this);
		}
	}
}