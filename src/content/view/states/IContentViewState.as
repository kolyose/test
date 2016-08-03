package content.view.states
{
	public interface IContentViewState
	{
		function entry():void;
		function exit():void;
		function display():void;
		function hide():void;		
		function setData(data:*):void;
	}
}