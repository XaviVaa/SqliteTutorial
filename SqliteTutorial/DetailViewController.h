//
//  DetailViewController.h
//  SqliteTutorial
//
//  Created by Lan on 30/07/13.
//  Copyright (c) 2013 Miyo's Inc. All rights reserved.
//

#import "ViewController.h"
#import "Tutorial.h"

@interface DetailViewController : ViewController
{
    IBOutlet UILabel *nombreLabel;
    IBOutlet UILabel *sistemaLabel;
    IBOutlet UILabel *terminadoLabel;
}

@property(nonatomic, retain) Tutorial *auxTutorial;
@end
