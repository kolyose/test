package content.view
{
	import content.ContentType;
	import content.view.states.IContentViewStatesFactory;
	
	import flash.filesystem.File;
	
	import pl.mllr.extensions.vfrPdfReader.VfrPdfReader;
	
	import starling.utils.SystemUtil;
	
	public class PdfContentView extends BaseNon2DContentView
	{
		private var _vfrReader:VfrPdfReader;
		
		public function PdfContentView()
		{
			super();
		}
		
		override public function getType():uint
		{			
			return ContentType.PDF;
		}
		
		override public function init():void
		{
			super.init();
			_vfrReader = new VfrPdfReader();
		}
		
		override public function startRender():void
		{
			if (!_vfrReader.showFile(_data))
			{
				var file:File = File.applicationStorageDirectory.resolvePath(_data);
				file.openWithDefaultApplication();		
			}			
		}		
	}
}