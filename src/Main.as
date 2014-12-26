package {

    import flash.display.Sprite;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.events.StatusEvent;
    import flash.net.LocalConnection;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.utils.setInterval;

    [SWF(width="600", height="700", frameRate=60)]
    public class Main extends Sprite {

        private var _connection:LocalConnection;
        private var _client:LCClient;

        private static const CONNECTION_NAME:String = "lclogger";
        private var _textField:TextField;

        public function Main() {

            setupConnection();
            setupUI();

            addListeners();
            //test();
        }

        private function addListeners():void {
            _client.addEventListener(ClientEvent.DATA_ADDED, onDataAdded);
        }

        private function onDataAdded(event:ClientEvent):void {
            var needToScroll:Boolean = _textField.scrollV == _textField.maxScrollV;
            _textField.appendText(event.data + "\n");
            if(needToScroll){
                scrollToEnd();
            }
        }

        private function test():void {
            setInterval(function():void{
                _client.dispatchEvent(new ClientEvent(ClientEvent.DATA_ADDED, "test"));
            }, 100);
        }

        private function scrollToEnd():void {
            _textField.scrollV = _textField.maxScrollV;
        }

        private function setupUI():void {

            stage.align = "TL";
            stage.scaleMode = StageScaleMode.NO_SCALE;

            stage.addEventListener(Event.RESIZE, onStageResized);

            var fmt:TextFormat = new TextFormat();
            fmt.font = "Menlo";

            _textField = new TextField();
            _textField.defaultTextFormat = fmt;
            _textField.wordWrap = true;
            addChild(_textField);

            onStageResized(null);
        }

        private function onStageResized(event:Event):void {
            _textField.width = stage.stageWidth;
            _textField.height = stage.stageHeight;
        }

        private function setupConnection():void {

            _client = new LCClient();

            _connection = new LocalConnection();
            _connection.addEventListener(StatusEvent.STATUS, onConnectionStatus);
            _connection.client = _client;

            _connection.connect(CONNECTION_NAME);
        }

        private function onConnectionStatus(event:StatusEvent):void {
            trace("onConnectionStatus", event);
        }
    }
}
