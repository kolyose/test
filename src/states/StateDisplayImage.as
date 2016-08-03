package states
{
	import content.ContentType;

	public class StateDisplayImage extends BaseStateDisplayStarlingOverlay
	{
		public function StateDisplayImage(application:Application, statesFactory:ApplicationStatesFactory)
		{
			super(application, statesFactory);
		}
		
		override public function entry():void
		{
			super.entry();
			_application.displayContentByType(ContentType.IMAGE);
		}
		
		override public function exit():void
		{
			super.exit();
			_application.hideContentByType(ContentType.IMAGE);
		}
		
		override public function displayImage():void
		{
			//should be empty
		}		
	}
}