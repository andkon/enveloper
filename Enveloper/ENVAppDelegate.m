//
//  ENVAppDelegate.m
//  Enveloper
//
//  Created by AK on 1/3/2014.
//  Copyright (c) 2014 Andrew Konoff. All rights reserved.
//

#import "ENVAppDelegate.h"

static ENVAppDelegate *launchedDelegate;

@implementation ENVAppDelegate

- (NSString *)filePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"data.archive"];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // This is where you decode the data you store, if it's been made.
    
    launchedDelegate = self;
    self.financialDict = [[NSMutableDictionary alloc] init];
    
    NSString *filePath = [self filePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSData *data = [[NSMutableData alloc] initWithContentsOfFile:filePath];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        self.financialDict = [unarchiver decodeObjectForKey:@"financialDict"];
    } else {
        NSArray *keys = [[NSArray alloc] initWithObjects:@"income", @"needs", @"wants", nil];
        NSArray *values = [[NSArray alloc] initWithObjects:@0, @{}, @{}, nil];
        self.financialDict = [[[NSDictionary alloc] initWithObjects:values forKeys:keys] mutableCopy];
    }
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // This is where you encode the data you store.
    
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self.financialDict forKey:@"financialDict"];
    [archiver finishEncoding];
    NSError *error = nil;
    NSString *filePath = [self filePath];
    BOOL success = [data writeToFile:filePath options:NSDataWritingAtomic error: &error];
    if (!success) {
        NSLog(@"writeToFile failed with error %@", error);
    }
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
