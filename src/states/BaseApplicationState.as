package states
{
	public class BaseApplicationState implements IApplicationState
	{
		protected var _application:Application;
		protected var _statesFactory:ApplicationStatesFactory;
		
		public function BaseApplicationState(application:Application, statesFactory:ApplicationStatesFactory)
		{
			_application = application;
			_statesFactory = statesFactory;
		}
		
		public function render():void
		{
			_application.renderStarling();
		}
		
		public function entry():void{}
		public function exit():void{}		
		public function dataLoadComplete():void{}		
		public function initializationComplete():void{}		
		public function display3D():void{}		
		public function displayImage():void{}		
		public function displayPdf():void{}		
		public function displayText():void{}		
		public function displayVideo():void{}
		
	}
}