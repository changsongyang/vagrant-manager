//
//  OutputWindow.m
//  Vagrant Manager
//
//  Created by Chris Ayoub on 1/8/14.
//  Copyright (c) 2014 Amitai Lanciano. All rights reserved.
//

#import "OutputWindow.h"
#import "AppDelegate.h"

@interface OutputWindow ()

@end

@implementation OutputWindow

- (id)initWithWindow:(NSWindow *)window {
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)windowDidLoad {
    [super windowDidLoad];
    
    NSPipe *taskOutputPipe = [NSPipe pipe];
    [self.task setStandardInput:[NSPipe pipe]];
    [self.task setStandardOutput:taskOutputPipe];
    [self.task setStandardError:taskOutputPipe];
    
    NSFileHandle *fh = [taskOutputPipe fileHandleForReading];
    [fh waitForDataInBackgroundAndNotify];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedOutput:) name:NSFileHandleDataAvailableNotification object:fh];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TaskCompletion:)  name: NSTaskDidTerminateNotification object:self.task];
    
    self.taskStatusLabel.stringValue = @"Running task...";
    [self.progressBar startAnimation:self];

    [self.task launch];
}

-(void) TaskCompletion :(NSNotification*)notif {
    NSTask *task = [notif object];
    
    [self.progressBar stopAnimation:self];
    [self.progressBar setIndeterminate:NO];
    [self.progressBar setDoubleValue:self.progressBar.maxValue];
    
    NSButton *closeButton = [self.window standardWindowButton:NSWindowCloseButton];
    [closeButton setEnabled:YES];
    
    [self.closeWindowButton setEnabled:YES];

    if(task.terminationStatus != 0) {
        self.taskStatusLabel.stringValue = @"Completed with errors";
    } else {
        self.taskStatusLabel.stringValue = @"Completed successfully";
    }
}

- (void)windowWillClose:(NSNotification *)notification {
    AppDelegate *app = (AppDelegate*)[[NSApplication sharedApplication] delegate];
    
    NSLog(@"Close");
    
    [app removeOutputWindow:self];
}

- (void)receivedOutput:(NSNotification*)notif {
    NSFileHandle *fh = [notif object];
    NSData *data = [fh availableData];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    
    // Smart Scrolling
    BOOL scroll = (NSMaxY(self.outputTextView.visibleRect) == NSMaxY(self.outputTextView.bounds));
    
    // Append string to textview
    [self.outputTextView.textStorage appendAttributedString:[[NSAttributedString alloc]initWithString:str]];
    
    if (scroll) // Scroll to end of the textview contents
        [self.outputTextView scrollRangeToVisible: NSMakeRange(self.outputTextView.string.length, 0)];
    
    [fh waitForDataInBackgroundAndNotify];
}

- (IBAction)closeButtonClicked:(id)sender {
    [self close];
}

@end
