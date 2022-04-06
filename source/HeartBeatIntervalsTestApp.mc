import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;


class HeartBeatIntervalsTestApp extends Application.AppBase {
    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        var secTimer = new Timer.Timer();
		secTimer.start(method(:driver), 1000, true);
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        var view = new HeartBeatIntervalsTestView();
        var delegate = new HeartBeatIntervalsTestDelegate(view); 
        return [ view, delegate ] as Array<Views or InputDelegates>;
    }

    function driver() {
	    WatchUi.requestUpdate();
	}
}

function getApp() as HeartBeatIntervalsTestApp {
    return Application.getApp() as HeartBeatIntervalsTestApp;
}