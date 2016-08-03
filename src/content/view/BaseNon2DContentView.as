package content.view
{
	import content.view.states.IContentViewState;
	import content.view.states.IContentViewStatesFactory;
	
	public class BaseNon2DContentView implements IContentView
	{
		protected var _state:IContentViewState;
		protected var _data:*;
				
		public function BaseNon2DContentView()
		{
			
		}
		
		public function init():void
		{
		}	
		
		public function startRender():void
		{
		}
		
		public function stopRender():void
		{
		}
		
		public function saveData(data:*):void
		{
			_data = data;
		}
		
		public function getType():uint
		{			
			return 0;
		}
		
		final public function display():void
		{
			_state.display();
		}		
		
		final public function hide():void
		{
			_state.hide();
		}	
		
		final public function setData(data:*):void
		{
			_state.setData(data);
		}
		
		final public function applyState(newState:IContentViewState):void
		{
			if (_state)
			{
				_state.exit();
				_state = null;
			}
			
			_state = newState;
			_state.entry();
		}
	}
}