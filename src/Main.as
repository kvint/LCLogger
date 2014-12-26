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

        private static const CONNECTION_NAME:String = "lclogger";
        private var _textField:TextField;

        public function Main() {

            setupConnection();
            setupUI();

            test();
        }

        private function test():void {
            setInterval(function():void{
                _textField.appendText("test lorem ipsum " + Math.random());
                _textField.scrollV = _textField.maxScrollV;
            }, 100);
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
            _connection = new LocalConnection();
            _connection.addEventListener(StatusEvent.STATUS, onConnectionStatus);
            _connection.client = new LCClient();

            _connection.connect(CONNECTION_NAME);
        }

        private function onConnectionStatus(event:StatusEvent):void {
            trace("onConnectionStatus", event);
        }
    }
}
