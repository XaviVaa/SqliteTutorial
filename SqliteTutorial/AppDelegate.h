//
//  AppDelegate.h
//  SqliteTutorial
//
//  Created by Lan on 29/07/13.
//  Copyright (c) 2013 Miyo's Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    // Variables de la base de datos
    NSString *databaseName;
    NSString *databasePath;
}

// Variables de la base de datos
@property (nonatomic, retain) NSString *databaseName;
@property (nonatomic, retain) NSString *databasePath;

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;

// Método para iniciar la base de datos y moverla de directorio si es necesario.
-(void)loadDB;

@end
