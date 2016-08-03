package content.view.states
{
	import content.view.IContentView;

	public interface IContentViewStatesFactory
	{
		function getStateInitital(view:IContentView):IContentViewState;
		function getStatePendingDisplay(view:IContentView):IContentViewState;
		function getStateReadyToDisplay(view:IContentView):IContentViewState;
		function getStateDisplaying(view:IContentView):IContentViewState;
	}
}