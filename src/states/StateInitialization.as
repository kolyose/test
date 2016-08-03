package states
{
	public class StateInitialization extends BaseApplicationState
	{
		public function StateInitialization(application:Application, statesFactory:ApplicationStatesFactory)
		{
			super(application, statesFactory);
		}
		
		override public function entry():void
		{
			_application.startInitialization();
		}
		
		override public function initializationComplete():void
		{					
			_application.startRendering();
			_application.applyState(_statesFactory.getStateDisplay3D());
		}	
	}
}