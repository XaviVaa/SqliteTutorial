//
//  ViewController.m
//  SqliteTutorial
//
//  Created by Lan on 29/07/13.
//  Copyright (c) 2013 Miyo's Inc. All rights reserved.
//

#import "ViewController.h"
#import "AddViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addTutorial
{
    AddViewController *addController = [[AddViewController alloc]initWithNibName:nil bundle:nil];
    
    [self.navigationController pushViewController:addController animated:YES];
}

- (IBAction)listado
{
    
}

@end
