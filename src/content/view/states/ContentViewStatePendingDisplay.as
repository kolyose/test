package content.view.states
{
	import content.view.IContentView;

	public class ContentViewStatePendingDisplay extends BaseContentViewState
	{
		public function ContentViewStatePendingDisplay(view:IContentView, statesFactory:IContentViewStatesFactory)
		{
			super(view, statesFactory);
		}
		
		override public function hide():void
		{
			_view.applyState(_statesFactory.getStateInitital(_view));
		}
		
		override public function setData(data:*):void
		{
			_view.saveData(data);
			_view.applyState(_statesFactory.getStateDisplaying(_view));
		}
		
	}
}