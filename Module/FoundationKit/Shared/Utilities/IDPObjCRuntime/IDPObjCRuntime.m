//
//  NSObject+IDPRuntimeExtensions.h
//  iOS
//
//  Created by Oleksa Korin on 30/1/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "IDPObjCRuntime.h"

NSString *IDPKVOClassNameWithClass(Class cls) {
    return [NSString stringWithFormat:@"NSKVONotifying_%@", NSStringFromClass(cls)];
}
