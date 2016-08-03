package strategies
{
	import content.dataProvider.IContentDataProvider;
	import content.dataProvider.states.IContentDataState;
	import content.dataProvider.states.IContentDataStatesFactory;

	public class OnlineLoadingStrategy implements IContentLoadingStrategy
	{
		public function OnlineLoadingStrategy()
		{
		}
		
		public function getContentDataFirstState(dataProvider:IContentDataProvider, statesFactory:IContentDataStatesFactory):IContentDataState
		{
			return statesFactory.getStateInitial(dataProvider);
		}
	}
}