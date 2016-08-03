package states
{
	public interface IApplicationState
	{
		function entry():void;
		function exit():void;
		
		function render():void;
		function dataLoadComplete():void;
		function initializationComplete():void;
		function display3D():void;
		function displayText():void;
		function displayImage():void;
		function displayPdf():void;
		function displayVideo():void;
	}
}