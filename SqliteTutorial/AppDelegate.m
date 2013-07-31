//
//  AppDelegate.m
//  SqliteTutorial
//
//  Created by Lan on 29/07/13.
//  Copyright (c) 2013 Miyo's Inc. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

@implementation AppDelegate

// Variables para que el resto de clases encuentren la base de datos.
@synthesize databaseName, databasePath;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Ruta para la base de datos. Estará en Library que es privada, ya que Documents se comparte con el usuario mediante iTunes.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    // Añadimos el nombre del fichero de la base de datos
    self.databasePath = [documentsDirectory stringByAppendingPathComponent:@"ApprendemosBD.sqlite"];
    
    // Cargo la base de datos
    [self loadDB];
    //líneas por defecto. Crea la ventana, y el controlador principal.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    // Creamos el navigation controller, poniéndole como principal suyo al view controller
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:self.viewController];
    // Establecemos como principal de la ventana el navigation.
    self.window.rootViewController = navController;
    navController.navigationBar.barStyle = UIBarStyleBlack;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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

- (void)loadDB
{
    BOOL exito;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *error;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    
    NSString *libraryDirectory = [paths objectAtIndex:0];
    
    NSString *writableDBPath = [libraryDirectory stringByAppendingPathComponent:@"ApprendemosBD.sqlite"];
    
    exito = [fileManager fileExistsAtPath:writableDBPath];
    
    if(exito) return;
    
    // Si no existe en library la copio desde el original.
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ApprendemosBD.sqlite"];
    
    exito = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    
    if(!exito){
        NSAssert1(0, @"Error al cargar la base de datos, error = '%@'.", [error localizedDescription]);
    }
}

@end
