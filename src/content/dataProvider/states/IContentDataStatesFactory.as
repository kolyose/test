package content.dataProvider.states
{
	import content.dataProvider.IContentDataProvider;

	public interface IContentDataStatesFactory
	{
		function getStateInitial(item:IContentDataProvider):IContentDataState;
		function getStateLoading(item:IContentDataProvider):IContentDataState;
		function getStateReadyOffline(item:IContentDataProvider):IContentDataState;
	}
}