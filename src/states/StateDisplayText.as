package states
{
	import content.ContentType;

	public class StateDisplayText extends BaseStateDisplayStarlingOverlay
	{
		public function StateDisplayText(application:Application, statesFactory:ApplicationStatesFactory)
		{
			super(application, statesFactory);
		}
		
		override public function entry():void
		{
			super.entry();
			_application.displayContentByType(ContentType.TEXT);
		}
		
		override public function exit():void
		{
			super.exit();
			_application.hideContentByType(ContentType.TEXT);
		}
		
		
		override public function displayText():void
		{
			//should be empty
		}		
	}
}