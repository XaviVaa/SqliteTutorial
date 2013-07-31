//
//  DetailViewController.m
//  SqliteTutorial
//
//  Created by Lan on 30/07/13.
//  Copyright (c) 2013 Miyo's Inc. All rights reserved.
//

#import "DetailViewController.h"
#import "EditViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController;

@synthesize auxTutorial;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
    nombreLabel.text = auxTutorial.nombre;
    sistemaLabel.text = auxTutorial.sistema;
    
    if(auxTutorial.terminado)
    {
        terminadoLabel.text = @"Si";
    } else {
        terminadoLabel.text = @"No";
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)Editar
{
    EditViewController *editController = [[EditViewController alloc]initWithNibName:nil bundle:nil];
    
    editController.auxTutorial = self.auxTutorial;
    
    [self.navigationController pushViewController:editController animated:YES];
}

-(IBAction)Eliminar
{
    // Ahora instanciamos la variable database de tipo sqlite3
    sqlite3 *database;
    
    // Creamos el sqlite3_stmt que contendrá después la sentencia a ejecutar compilada.
    sqlite3_stmt *compiledStatement;
    
    // Abrimos la base de datos de la ruta indicada en el delegate
    if(sqlite3_open([appDelegate.databasePath UTF8String], &database) == SQLITE_OK) {
        
        // Si no ha habido errores al abrir, creamos la sentencia de inserción.
        // Como id_noticia es autoincremental, no lo indicaremos nosotros.
        NSString *sqlStatement = [NSString stringWithFormat:@"DELETE FROM Tutoriales WHERE id_tutorial = \"%d\"",
                                  auxTutorial.id_tutorial
                                  ];
        
        
        
        
        // Lanzamos la consulta y recorremos los resultados si todo ha ido OK
        if(sqlite3_prepare_v2(database, [sqlStatement UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK) {
            
            // En otros casos recorremos los resultados. En este caso no habrá.
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                
            }
            
        } else {
            // Puedo informar si ha habido algún error
        }
        
        // Libero la consulta
        sqlite3_finalize(compiledStatement);
        
    }
    // Cierro la base de datos
    sqlite3_close(database);
    
    // Si todo ha ido bien podemos abandonar la ventana e ir a la superior.
    //Aquí también podéis utilizar un UIAlertView para notificar al usuario de que la inserción ha sido correcta.
    [self.navigationController popViewControllerAnimated:YES];
}

@end
