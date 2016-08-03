package states
{
	public class ApplicationStatesFactory
	{
		private var _application:Application;
		
		public function ApplicationStatesFactory(application:Application)
		{
			_application = application;
		}
		
		public function getStateLoadingData():IApplicationState
		{
			return new StateLoadingData(_application, this);
		}
		
		public function getStateInitialization():IApplicationState
		{
			return new StateInitialization(_application, this);
		}
				
		public function getStateDisplay3D():IApplicationState
		{
			return new StateDisplay3D(_application, this);
		}
		
		public function getStateDisplayText():IApplicationState
		{
			return new StateDisplayText(_application, this);
		}
		
		public function getStateDisplayImage():IApplicationState
		{
			return new StateDisplayImage(_application, this);
		}
		
		public function getStateDisplayPdf():IApplicationState
		{
			return new StateDisplayPdf(_application, this);
		}
		
		public function getStateDisplayVideo():IApplicationState
		{
			return new StateDisplayVideo(_application, this);
		}
	}
}