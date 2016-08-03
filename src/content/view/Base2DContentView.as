package content.view
{
	import content.view.states.IContentViewState;
	import content.view.states.IContentViewStatesFactory;
	
	import starling.display.Sprite;
	import starling.events.Event;

	public class Base2DContentView extends Sprite implements IContentView
	{
		protected var _state:IContentViewState;
		protected var _data:*;
		
		public function Base2DContentView()
		{
			
		}
		
		//view specific methods
		public function init():void
		{
			if (stage)
				onAddedToStage();
			else
				addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		protected function onAddedToStage(event:Event=null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function startRender():void
		{
			visible = true;
		}
		
		public function stopRender():void
		{
			visible = false;
		}
		
		public function saveData(data:*):void
		{
			_data = data;
		}
		
		public function getType():uint
		{			
			return 0;
		}
		
		//state specific methods
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