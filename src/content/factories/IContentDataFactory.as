package content.factories
{
	import content.dataProvider.IContentDataProvider;

	public interface IContentDataFactory
	{
		function getContentDataByType(type:uint, data:Object):IContentDataProvider;
	}
}