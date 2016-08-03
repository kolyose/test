package strategies
{
	import content.dataProvider.IContentDataProvider;
	import content.dataProvider.states.IContentDataState;
	import content.dataProvider.states.IContentDataStatesFactory;

	public interface IContentLoadingStrategy
	{
		function getContentDataFirstState(dataProvider:IContentDataProvider, statesFactory:IContentDataStatesFactory):IContentDataState;
	}
}