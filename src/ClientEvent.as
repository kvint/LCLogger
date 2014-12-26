/**
 * Created by kvint on 26.12.14.
 */
package {
	import flash.events.Event;

	public class ClientEvent extends Event {

		public static const DATA_ADDED:String = "onDataAdded";
		private var _data:String;

		public function ClientEvent(type:String, data:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			_data = data;
		}

		override public function clone():Event {
			return new ClientEvent(type, data, bubbles, cancelable);
		}

		public function get data():String {
			return _data;
		}
	}
}
