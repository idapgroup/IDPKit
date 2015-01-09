//
//  IDPSerializableObject.h
//  IDPKit
//
//  Created by Oleksa 'trimm' Korin on 5/25/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IDPSerialization <NSObject>

/** 
 This method returns the serialized string from current object.
 @return This method returns the serialized string from current object.
*/
- (NSString *)serialize;

@end
