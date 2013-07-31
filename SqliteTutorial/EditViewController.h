//
//  EditViewController.h
//  SqliteTutorial
//
//  Created by Lan on 31/07/13.
//  Copyright (c) 2013 Miyo's Inc. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Tutorial.h"

@interface EditViewController : ViewController
{
    IBOutlet UITextField *nombreTextField;
    IBOutlet UISegmentedControl *sistemaSegControl;
    IBOutlet UISwitch *terminadoSwitch;
    AppDelegate *appDelegate;
    Tutorial *auxTutorial;
}

@property(nonatomic, retain) Tutorial *auxTutorial;

-(IBAction)updateTutorial;
-(IBAction)esconderTeclado;
@end
