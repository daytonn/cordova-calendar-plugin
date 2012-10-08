//
//  CordovaCalendar.m
//  Mixn
//
//  Created by Dayton Nolan on 10/1/12.
//  Copyright (c) 2012 DevMynd. All rights reserved.
//

#import "CordovaCalendar.h"
#import <Cordova/CDV.h>

@implementation CordovaCalendar

    - (void) addEvent:(CDVInvokedUrlCommand*)command
    {
        [self setCommand: command];
        // Get the arguments to the plugin
        NSString* startDate = [command.arguments objectAtIndex:0];
        NSString* endDate = [command.arguments objectAtIndex:1];
        NSString* title = [command.arguments objectAtIndex:2];
        [self createEvent: startDate endDate: endDate title: title];
    }

    - (void) createEvent:(NSString*)startDate endDate:(NSString*)endDate title:(NSString*)title
    {
        // Setup a date formatter
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];

        // Setup the event database for the event
        EKEventStore* eventDB = [[EKEventStore alloc] init];
        EKEvent* newEvent = [EKEvent eventWithEventStore:eventDB];

        newEvent.title = title;
        newEvent.startDate = [dateFormatter dateFromString:startDate];
        newEvent.endDate = [dateFormatter dateFromString:endDate];
        newEvent.allDay = NO;
        newEvent.calendar = [eventDB defaultCalendarForNewEvents];

        NSError* error;
        if ([eventDB saveEvent: newEvent span:EKSpanThisEvent commit:YES error: &error]) {
            [self eventDidSaveSuccessfully];
        }
        else {
            [self eventDidNotSaveSuccessfully];
        }
    }

    - (void) eventDidSaveSuccessfully
    {
        NSLog(@"Event saved");
        [self setPluginResult: [CDVPluginResult resultWithStatus:CDVCommandStatus_OK]];
        [self setJavaScript: [[self pluginResult] toSuccessCallbackString:_command.callbackId]];
        [self writeJavascript: [self javaScript]];
    }

    - (void) eventDidNotSaveSuccessfully
    {
        NSLog(@"Event not saved");
        [self setPluginResult: [CDVPluginResult
              resultWithStatus: CDVCommandStatus_JSON_EXCEPTION
              messageAsString: @"CordovaCalendar.addEvent(startDate, endDate, title): There were errors saving the event"]];
        [self setJavaScript: [[self pluginResult] toErrorCallbackString:_command.callbackId]];
        [self writeJavascript: [self javaScript]];
    }

    //delegate method for EKEventEditViewDelegate
    -(void) eventEditViewController:(EKEventEditViewController *) controller
            didCompleteWithAction:(EKEventEditViewAction) action
    {
        //[self dismissModalViewControllerAnimated:YES];
        [self release];
    }

@end