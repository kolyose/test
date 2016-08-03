package states
{
	public class BaseStateDisplayStarlingOverlay extends BaseApplicationState
	{
		public function BaseStateDisplayStarlingOverlay(application:Application, statesFactory:ApplicationStatesFactory)
		{
			super(application, statesFactory);
		}
		
		override public function entry():void
		{
			
		}	
		
		override public function display3D():void
		{
			_application.applyState(_statesFactory.getStateDisplay3D());
		}	
		
		override public function displayImage():void
		{
			_application.applyState(_statesFactory.getStateDisplayImage());
		}		
		
		override public function displayPdf():void
		{
			_application.applyState(_statesFactory.getStateDisplayPdf());
		}
		
		override public function displayText():void
		{
			_application.applyState(_statesFactory.getStateDisplayText());
		}
		
		override public function displayVideo():void
		{
			_application.applyState(_statesFactory.getStateDisplayVideo());
		}
	}
}