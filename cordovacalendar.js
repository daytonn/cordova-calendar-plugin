var CordovaCalendar = {
  addEvent: function(eventObject, successCallback, errorCallback) {

    successCallback = successCallback || function() {
      console.log(eventObject.title + " saved to calendar");
    };

    errorCallback = errorCallback || function(error) {
      console.log('CordovaCalendar.addEvent(event): ' + eventObject.title + " could not be saved to the calendar");
      console.log(error);
    };

    var args = [eventObject.startDate, eventObject.endDate, eventObject.title];
    cordova.exec(successCallback, errorCallback, "CordovaCalendar", "addEvent", args);

  }
};