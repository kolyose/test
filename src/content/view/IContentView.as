package content.view
{
	import content.view.states.IContentViewState;

	public interface IContentView
	{
		function init():void;
		function display():void;
		function hide():void;
		function setData(data:*):void;
		function applyState(newState:IContentViewState):void;		
		function startRender():void;
		function stopRender():void;
		function saveData(data:*):void;
		function getType():uint;
	}
}