//
//  AddViewController.h
//  SqliteTutorial
//
//  Created by Lan on 29/07/13.
//  Copyright (c) 2013 Miyo's Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "AppDelegate.h"
#import "Tutorial.h"

@interface AddViewController : UIViewController
{
    IBOutlet UITextField *nombreTextField;
    IBOutlet UISegmentedControl *sistemaSegControl;
    IBOutlet UISwitch *terminadoSwitch;
    AppDelegate *appDelegate;
    Tutorial *auxTutorial;
}

-(IBAction)addTutorial;
-(IBAction)esconderTeclado;

//Cambio de prueba
@end
