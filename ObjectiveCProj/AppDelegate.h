//
//  AppDelegate.h
//  ObjectiveCProj
//
//  Created by Vivek on 8/10/20.
//  Copyright © 2020 Vivek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow * window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

