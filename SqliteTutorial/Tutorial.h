//
//  Tutorial.h
//  SqliteTutorial
//
//  Created by Lan on 29/07/13.
//  Copyright (c) 2013 Miyo's Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tutorial : NSObject
{
    
}

@property(nonatomic) int id_tutorial;
@property(nonatomic, retain) NSString *sistema;
@property(nonatomic, retain) NSString *nombre;
@property(nonatomic) bool terminado;
@end
