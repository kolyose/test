package content.dataProvider.states
{
	import content.dataProvider.IContentDataProvider;
	
	public class ContentDataStateInitial extends BaseContentDataState
	{
		public function ContentDataStateInitial(item:IContentDataProvider, statesFactory:IContentDataStatesFactory)
		{
			super(item, statesFactory);
		}
		
		override public function load():void
		{
			_data.applyState(_statesFactory.getStateLoading(_data));
		}
		
		override public function getSource():*
		{			
			return _data.getUrl();
		}		
	}
}