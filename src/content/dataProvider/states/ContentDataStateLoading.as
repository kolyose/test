package content.dataProvider.states
{
	import content.dataProvider.IContentDataProvider;
	
	public class ContentDataStateLoading extends BaseContentDataState
	{
		public function ContentDataStateLoading(item:IContentDataProvider, statesFactory:IContentDataStatesFactory)
		{
			super(item, statesFactory);
		}
		
		override public function entry():void
		{
			_data.loadContent();
		}		
		
		override public function loadComplete():void
		{
			_data.applyState(_statesFactory.getStateReadyOffline(_data));
		}
	}
}