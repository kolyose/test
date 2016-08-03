package content.view.states
{
	import content.view.IContentView;

	public class ContentViewStatesFactory implements IContentViewStatesFactory
	{
		public function ContentViewStatesFactory()
		{
		}
		
		public function getStateInitital(view:IContentView):IContentViewState
		{
			return new ContentViewStateInitial(view, this);
		}
		
		public function getStatePendingDisplay(view:IContentView):IContentViewState
		{
			return new ContentViewStatePendingDisplay(view, this);
		}
		
		public function getStateReadyToDisplay(view:IContentView):IContentViewState
		{
			return new ContentViewStateReadyToDisplay(view, this);
		}
		
		public function getStateDisplaying(view:IContentView):IContentViewState
		{
			return new ContentViewStateDisplaying(view, this);
		}
	}
}