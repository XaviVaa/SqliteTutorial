//
//  ListViewController.m
//  SqliteTutorial
//
//  Created by Lan on 30/07/13.
//  Copyright (c) 2013 Miyo's Inc. All rights reserved.
//

#import "ListViewController.h"
#import "Tutorial.h"
#import "DetailViewController.h"

@interface ListViewController ()

@end

@implementation ListViewController;
@synthesize tutorialsArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //tutorialsArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    tutorialsArray = [[NSMutableArray alloc]init];
    [self loadTutorialsFromDB];
    [tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    return [tutorialsArray count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Creamos una instancia del controlador de la vista detalle.
    DetailViewController *detailController = [[DetailViewController alloc]initWithNibName:nil bundle:nil];
    
    // Recuperamos el tutoriial de la posicion del array igual a la fila seleccionada.
    Tutorial *auxTutorial = [tutorialsArray objectAtIndex:indexPath.row];
    
    // Establecemos al controlador el tutorial que debemos pasarle.
    [detailController setAuxTutorial:auxTutorial];
    
    // Lanzamos el controlador de detalle de nuestro tutorial.
    [self.navigationController pushViewController:detailController animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    
    cell.backgroundColor = [UIColor colorWithRed:100.0/255.0 green:125.0/255.0 blue:30.0/255.0 alpha:1.0];
    cell.contentView.backgroundColor = [UIColor colorWithRed:221.0/255.0 green:238.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    // Creamos una etiqueta (UILabel) para mostrar el nombre de los tutoriales en cada fila
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 0.0, cell.frame.size.width - 40, tableView.rowHeight)];
    
    label.textAlignment = NSTextAlignmentLeft;
    
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:20.0];
    label.shadowColor = [UIColor blackColor];
    label.shadowOffset = CGSizeMake(1, 1);
    
    // Le establecemos el nombre segun el tutorial recuperado del array
    Tutorial *auxTutorial = [tutorialsArray objectAtIndex:indexPath.row];
    label.text = [auxTutorial nombre];
    
    // Y añadimos la etiqueta al contenido de la vista
    [cell.contentView addSubview:label];
    
    
    return cell;
    
}

-(void)loadTutorialsFromDB
{
    sqlite3 *database;
    
    sqlite3_stmt *compiledStatement;
    
    // Abrimos la base de datos de la ruta indicada en el delegate
    if(sqlite3_open([appDelegate.databasePath UTF8String], &database) == SQLITE_OK){
       
        // Podriamos seleccionar solo algunos, o todos en el orden deseado asi:
        // NSString *sqlStatement = [NSString stringWithFormat:@"select id_tutorial, sistema, terminado from tutoriales"];
        
        NSString *sqlStatement = [NSString stringWithFormat:@"select * from Tutoriales"];
        
        // Lanzamos la consulta y recorremos los resultados si todo ha sido OK
        if(sqlite3_prepare_v2(database, [sqlStatement UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK) {
            
            // Recorremos los resultados. En este caso no habra.
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                
                // Leemos las columnas necesarias. Aunque algunos valores son numericos, prefiero recuperarlos en string y convertirlos luego, porque da menos problemas.
                NSString *id_tutorialString = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
                NSString *sistema = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
                NSString *nombre = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
                NSString *terminadoString = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
                
                Tutorial *auxTutorial = [[Tutorial alloc]init];
                auxTutorial.id_tutorial = id_tutorialString.intValue;
                auxTutorial.sistema = sistema;
                auxTutorial.nombre = nombre;
                auxTutorial.terminado = terminadoString.boolValue;
                
                [tutorialsArray addObject:auxTutorial];
                NSLog(@"Tutorial count = %d",[tutorialsArray count]);
                
            }
        } else {
            // Informo si ha habido algun error
        }
        
        // Libero la consulta
        sqlite3_finalize(compiledStatement);
        
    }
    
    // Cierro la base de datos
    sqlite3_close(database);
    
}

@end
