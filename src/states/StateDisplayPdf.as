package states
{
	import content.ContentType;

	public class StateDisplayPdf extends BaseStateDisplayStarlingOverlay
	{
		public function StateDisplayPdf(application:Application, statesFactory:ApplicationStatesFactory)
		{
			super(application, statesFactory);
		}
		
		override public function entry():void
		{
			super.entry();
			_application.displayContentByType(ContentType.PDF);
		}
		
		override public function exit():void
		{
			super.exit();
			_application.hideContentByType(ContentType.PDF);
		}
		
		
		override public function displayPdf():void
		{
			//should be empty
		}		
	}
}