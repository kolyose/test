package content.view.states
{
	import content.view.IContentView;

	public class ContentViewStateDisplaying extends BaseContentViewState
	{
		public function ContentViewStateDisplaying(view:IContentView, statesFactory:IContentViewStatesFactory)
		{
			super(view, statesFactory);
		}
		
		override public function entry():void
		{
			_view.startRender();
		}
		
		override public function exit():void
		{
			_view.stopRender();
		}
		
		override public function hide():void
		{
			_view.applyState(_statesFactory.getStateReadyToDisplay(_view));
		}
		
	}
}