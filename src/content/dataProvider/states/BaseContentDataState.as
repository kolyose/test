package content.dataProvider.states
{
	import content.dataProvider.IContentDataProvider;

	public class BaseContentDataState implements IContentDataState
	{
		protected var _data:IContentDataProvider;
		protected var _statesFactory:IContentDataStatesFactory;
		
		public function BaseContentDataState(data:IContentDataProvider, statesFactory:IContentDataStatesFactory)
		{
			_data = data;
			_statesFactory = statesFactory;
		}
		
		public function entry():void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function exit():void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function load():void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function loadComplete():void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function getSource():*
		{
			// TODO Auto Generated method stub
			return null;
		}
		
		
	}
}