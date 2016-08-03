package content.view.states
{
	import content.view.IContentView;

	public class BaseContentViewState implements IContentViewState
	{
		protected var _view:IContentView;
		protected var _statesFactory:IContentViewStatesFactory;
		
		public function BaseContentViewState(view:IContentView, statesFactory:IContentViewStatesFactory)
		{
			_view = view;
			_statesFactory = statesFactory;
		}
		
		public function entry():void{}		
		public function exit():void{}
		public function display():void{}		
		public function hide():void{}
		public function setData(data:*):void{}
	}
}