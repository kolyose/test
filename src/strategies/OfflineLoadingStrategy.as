package strategies
{
	import content.dataProvider.IContentDataProvider;
	import content.dataProvider.states.IContentDataState;
	import content.dataProvider.states.IContentDataStatesFactory;

	public class OfflineLoadingStrategy implements IContentLoadingStrategy
	{
		public function OfflineLoadingStrategy()
		{
		}
		
		public function getContentDataFirstState(dataProvider:IContentDataProvider, statesFactory:IContentDataStatesFactory):IContentDataState
		{
			return statesFactory.getStateReadyOffline(dataProvider);
		}
		
	}
}