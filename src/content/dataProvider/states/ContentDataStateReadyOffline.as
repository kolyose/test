package content.dataProvider.states
{
	import content.dataProvider.IContentDataProvider;
	
	public class ContentDataStateReadyOffline extends BaseContentDataState
	{
		public function ContentDataStateReadyOffline(item:IContentDataProvider, statesFactory:IContentDataStatesFactory)
		{
			super(item, statesFactory);
		}
		
		override public function entry():void
		{
			if (_data.checkContentOffline())
			{
				_data.notifyLoadComplete();
			}
			else
			{
				_data.applyState(_statesFactory.getStateLoading(_data));
			}
		}
		
		override public function getSource():*
		{
			return _data.getLocalUrl();
		}		
	}
}