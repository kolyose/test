package content.view.states
{
	import content.view.IContentView;

	public class ContentViewStateInitial extends BaseContentViewState
	{
		public function ContentViewStateInitial(view:IContentView, statesFactory:IContentViewStatesFactory)
		{
			super(view, statesFactory);
		}
		
		override public function entry():void
		{
			_view.init();
			_view.stopRender();
		}		
		
		override public function display():void
		{
			_view.applyState(_statesFactory.getStatePendingDisplay(_view));
		}
		
		override public function setData(data:*):void
		{
			_view.saveData(data);
			_view.applyState(_statesFactory.getStateReadyToDisplay(_view));
		}		
	}
}