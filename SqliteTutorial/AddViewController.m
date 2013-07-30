//
//  AddViewController.m
//  SqliteTutorial
//
//  Created by Lan on 29/07/13.
//  Copyright (c) 2013 Miyo's Inc. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()

@end

@implementation AddViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addTutorial
{
    // Comprobamos que el usuario haya insertado un nombre, si no, no haremos cambio. podéis crear si quereis un UIAlertView para avisar al usuario. Nosotros ahora lo vamos a obviar.
    if(![nombreTextField.text isEqualToString:@""])
    {
        // En caso de que si que tenga nombre, comprobamos si auxTutorial existe. De no ser así (que debería ser lo normal), lo iniciamos.
        if(auxTutorial == nil)
        {
            auxTutorial = [[Tutorial alloc]init];
            
        }
        
        // Establecemos el nombre al objeto.
        auxTutorial.nombre = nombreTextField.text;
        
        // Establecemos el tipo de sistema en función del botón que haya pulsado en UISegmentedControl
        switch (sistemaSegControl.selectedSegmentIndex) {
            case 0:
                auxTutorial.sistema = @"iOS";
                break;
            case 1:
                auxTutorial.sistema = @"Android";
            default:
                break;
        }
        
        // Establecemos también el bool terminado, en función del valor del UISwitch
        auxTutorial.terminado = [terminadoSwitch isOn];
        
        
        // Ahora instanciamos la variable database de tipo sqlite3
        sqlite3 *database;
        
        // Creamos el sqlite3_stmt que contendrá después la sentencia a ejecutar compilada.
        sqlite3_stmt *compiledStatement;
        
        
        
        // Abrimos la base de datos de la ruta indicada en el delegate
        if(sqlite3_open([appDelegate.databasePath UTF8String], &database) == SQLITE_OK) {
            
            // Si no ha habido errores al abrir, creamos la sentencia de inserción.
            // Como id_noticia es autoincremental, no lo indicaremos nosotros.
            NSString *sqlStatement = [NSString stringWithFormat:@"Insert into Tutoriales (\"sistema\",\"nombre\", \"terminado\") VALUES (\"%@\",\"%@\",\"%d\")",
                                      auxTutorial.sistema,
                                      auxTutorial.nombre,
                                      auxTutorial.terminado
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
}

-(IBAction)esconderTeclado
{
    [nombreTextField resignFirstResponder];
}

@end
