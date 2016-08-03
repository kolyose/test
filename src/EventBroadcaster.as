package
{
	public class EventBroadcaster
	{
		private var _listenersByType:Object;
		
		public function EventBroadcaster()
		{
			_listenersByType = {};
		}
		
		public function addEventListener(type:String, listener:Function):void
		{
			if (_listenersByType[type] == undefined)			
				_listenersByType[type] = new Vector.<Function>();
			
			_listenersByType[type].push(listener);
		}
		
		public function removeEventListener(type:String, listener:Function):void
		{
			if (_listenersByType[type] == undefined) 
				return;
			
			var listenersVector:Vector.<Function> = _listenersByType[type] as Vector.<Function>;
			var listenerIndex:uint = listenersVector.indexOf(listener); 
			if (~listenerIndex)			
				listenersVector.splice(listenerIndex, 1);
		}
		
		public function dispatchEvent(type:String, ...data):void
		{
			if (_listenersByType[type] == undefined) 
				return;
			
			var listenersVector:Vector.<Function> = _listenersByType[type] as Vector.<Function>;
			var length:uint = listenersVector.length;
			for (var i:int=0; i<length; i++ )
			{
				listenersVector[i].apply(this, data);
			}
		}
	}
}