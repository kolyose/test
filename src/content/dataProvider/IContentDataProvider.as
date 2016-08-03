package content.dataProvider
{
	import content.dataProvider.states.IContentDataState;

	public interface IContentDataProvider
	{
		function applyState(newState:IContentDataState):void;
		function load():void;
		function loadContent():void;
		function notifyLoadComplete():void;
		function checkContentOffline():Boolean;
		function getUrl():String;
		function getLocalUrl():String;
		function getSource():*;
		function getType():uint;
	}
}