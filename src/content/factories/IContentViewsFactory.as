package content.factories
{
	import content.view.IContentView;

	public interface IContentViewsFactory
	{
		function getViewByType(type:uint):IContentView;
	}
}