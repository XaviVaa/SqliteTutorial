//
//  ListViewController.h
//  SqliteTutorial
//
//  Created by Lan on 30/07/13.
//  Copyright (c) 2013 Miyo's Inc. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ListViewController : ViewController
{
    // Declaramos la tabla y el delegate de la aplicacion
    IBOutlet UITableView *tableView;
    AppDelegate *appDelegate;
}

// Creamos una propiedad retain para el array que almacenara los tutoriales y con el poblaremos la tabla.
@property (nonatomic, retain) NSMutableArray *tutorialsArray;
//@property(nonatomic, strong) IBOutlet UITableView *tableView;

// Añadimos un metodo para la carga de nuestra base de datos
- (void)loadTutorialsFromDB;

@end
