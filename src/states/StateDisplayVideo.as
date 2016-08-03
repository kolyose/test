package states
{
	import content.ContentType;

	public class StateDisplayVideo extends BaseStateDisplayStarlingOverlay
	{
		public function StateDisplayVideo(application:Application, statesFactory:ApplicationStatesFactory)
		{
			super(application, statesFactory);
		}
		
		override public function entry():void
		{
			super.entry();
			_application.displayContentByType(ContentType.VIDEO);
		}
		
		override public function exit():void
		{
			super.exit();
			_application.hideContentByType(ContentType.VIDEO);
		}
		
		
		override public function displayVideo():void
		{
			//should be empty
		}		
	}
}