//
//  DetailViewController.m
//  SqliteTutorial
//
//  Created by Lan on 30/07/13.
//  Copyright (c) 2013 Miyo's Inc. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize auxTutorial;

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
    
    nombreLabel.text = auxTutorial.nombre;
    sistemaLabel.text = auxTutorial.sistema;
    
    if(auxTutorial.terminado)
    {
        terminadoLabel.text = @"Si";
    } else {
        terminadoLabel.text = @"No";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
