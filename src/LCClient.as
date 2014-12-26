/**
 * Created by kvint on 26.12.14.
 */
package {
	import flash.events.EventDispatcher;

	public class LCClient extends EventDispatcher {

		public function onMessageSent(message:*):void {
			dispatchEvent(new ClientEvent(ClientEvent.DATA_ADDED, "\nIncoming"));
			tryToOutputXML(message);
		}
		public function onMessageReceived(message:*):void {
			dispatchEvent(new ClientEvent(ClientEvent.DATA_ADDED, "\nOutgoing"));
			tryToOutputXML(message);
		}

		private function tryToOutputXML(message:*):void {
			var output:String = ""
			try {
				var xml:XML = new XML(String(message));
				output = xml.toXMLString()
			} catch (e:Error) {
				output = "*\n" + message;
			} finally {
				dispatchEvent(new ClientEvent(ClientEvent.DATA_ADDED, output));
			}
		}
		public function onFail(e:Error):void {
			trace("onFail\n", e);
		}
		public function defaultMethod(...args):void {
			trace("defaultMethod\n", args);
		}

	}
}
