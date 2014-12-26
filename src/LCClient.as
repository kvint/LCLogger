/**
 * Created by kvint on 26.12.14.
 */
package {
	public class LCClient {

		public function onMessageSent(message:*):void {
			trace("incoming\n", message);
		}
		public function onMessageReceived(message:*):void {
			trace("outgoing\n", message);
		}
		public function onFail(e:Error):void {
			trace("onFail\n", e);
		}
		public function defaultMethod(...args):void {
			trace("defaultMethod\n", args);
		}

	}
}
