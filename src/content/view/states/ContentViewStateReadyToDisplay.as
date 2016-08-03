package content.view.states
{
	import content.view.IContentView;
	
	public class ContentViewStateReadyToDisplay extends BaseContentViewState
	{
		public function ContentViewStateReadyToDisplay(view:IContentView, statesFactory:IContentViewStatesFactory)
		{
			super(view, statesFactory);
		}
		
		override public function display():void
		{
			_view.applyState(_statesFactory.getStateDisplaying(_view));
		}
		
	}
}