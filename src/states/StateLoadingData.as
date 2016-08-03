package states
{
	public class StateLoadingData extends BaseApplicationState
	{
		public function StateLoadingData(application:Application, statesFactory:ApplicationStatesFactory)
		{
			super(application, statesFactory);
		}
		
		override public function entry():void
		{
			_application.loadData();
		}
		
		override public function dataLoadComplete():void
		{
			_application.applyState(_statesFactory.getStateInitialization());
		}
	}
}