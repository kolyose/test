package content.dataProvider.states
{
	public interface IContentDataState
	{
		function entry():void;
		function exit():void;
		function load():void;
		function loadComplete():void;
		function getSource():*;
	}
}