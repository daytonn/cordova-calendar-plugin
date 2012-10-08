//
//  CordovaCalendar.h
//  Mixn
//
//  Created by Dayton Nolan on 10/1/12.
//  Copyright (c) 2012 DevMynd. All rights reserved.
//

#import <Cordova/CDV.h>
#import <EventKitUI/EventKitUI.h>
#import <EventKit/EventKit.h>

@interface CordovaCalendar : CDVPlugin <EKEventEditViewDelegate>

- (void) addEvent:(CDVInvokedUrlCommand*)command;
- (void) createEvent:(NSString*)startDate endDate:(NSString*)endDate title:(NSString*)title;
- (void) eventDidSaveSuccessfully;
- (void) eventDidNotSaveSuccessfully;

@property (nonatomic, assign) BOOL errorsOccured;
@property (nonatomic, strong) CDVPluginResult* pluginResult;
@property (nonatomic, strong) CDVInvokedUrlCommand* command;
@property (nonatomic, strong) NSString* javaScript;

@end