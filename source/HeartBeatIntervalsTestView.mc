import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Sensor;
import Toybox.Lang;
import Toybox.System;

class HeartBeatIntervalsTestView extends WatchUi.View {
    var lastHeartBeatInveralData = [];

    function initialize() {
        View.initialize();
        
        Sensor.setEnabledSensors([
			Sensor.SENSOR_HEARTRATE,
			Sensor.SENSOR_FOOTPOD
		]);
		
        setUpHighFrequencySensor();
    }

   	function setUpHighFrequencySensor() {
		var options = {
			:period => 1,
			:heartBeatIntervals => { :enabled => true }
		};

		Sensor.registerSensorDataListener(self.method(:onHighFrequencyData), options);
	}     

    function onHighFrequencyData(sensorData) {
		var heartRateData = sensorData.heartRateData;
		if (heartRateData != null) {
			var sample = heartRateData.heartBeatIntervals; // array of beat intervals in milliseconds
            lastHeartBeatInveralData = sample;
		}
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.clear();
        
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);

        var text = heartBeatIntervalText();
        var font = Graphics.FONT_MEDIUM;
        var x = dc.getWidth() / 2;
        var y = (dc.getHeight() / 2) - (dc.getFontHeight(font) / 2);
        var justification = Graphics.TEXT_JUSTIFY_CENTER;

        dc.drawText(x, y, font, text, justification);
    }

    function heartBeatIntervalText() {
        if (lastHeartBeatInveralData.size() == 0) {
            return "No Data";
        } else {
            var text = "";
            for(var i = 0; i < lastHeartBeatInveralData.size(); i++) {
                text += (" " + lastHeartBeatInveralData[i].toString()); 
            }
            return text;
        }
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }
}