//
//  ACModel.h
//  Accomplist
//
//  Created by Oleksa 'trimm' Korin on 4/14/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPObservableObject.h"
#import "IDPModelProtocol.h"

@interface IDPModel : IDPObservableObject <IDPModel>

- (void)notifyObserversOfSuccessfulLoad;
- (void)notifyObserversOfFailedLoad;
- (void)notifyObserversOfCancelledLoad;
- (void)notifyObserversOfChanges;
- (void)notifyObserversOfChangesWithMessage:(NSDictionary *)message;
- (void)notifyObserversOfUnload;

@end
