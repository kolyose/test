package states
{
	import content.ContentType;

	public class StateDisplay3D extends BaseApplicationState
	{
		public function StateDisplay3D(application:Application, statesFactory:ApplicationStatesFactory)
		{
			super(application, statesFactory);
		}
		
		override public function entry():void
		{
			super.entry();
			_application.displayContentByType(ContentType.MODEL3D);
		}
		
		override public function exit():void
		{
			super.exit();
			_application.hideContentByType(ContentType.MODEL3D);
		}
		
		override public function display3D():void
		{
			//should remain empty
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