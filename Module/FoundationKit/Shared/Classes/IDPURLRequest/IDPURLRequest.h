//
//  IDPURLRequest.h
//  IDPKit
//
//  Created by Oleksa 'trimm' Korin on 5/25/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPMutableDictionary.h"

#import "IDPSerialization.h"

extern NSString * const IDPRequestTypeGET;
extern NSString * const IDPRequestTypePOST;
extern NSString * const IDPRequestTypePUT;
extern NSString * const IDPRequestTypeDELETE;

@interface IDPURLRequest : IDPMutableDictionary

// host URL string
// should be in the form URL
// string form: scheme://host:port
@property (nonatomic, copy)     NSString        *host;

// is is equal to nil, then the / is used for
// URLRequest construction
@property (nonatomic, copy)     NSString        *path;

// the separator between path and parameters
// default value is '?'
@property (nonatomic, copy)     NSString        *pathSeparator;

// the separator between parameters
// default value is '&'
@property (nonatomic, copy)     NSString        *parameterSeparator;

// request type
@property (nonatomic, copy)     NSString        *method;

// property, that returns url request for current parameters
// default cache policy is NSURLRequestUseProtocolCachePolicy
// default timeout is 60 seconds
@property (nonatomic, readonly) NSMutableURLRequest    *urlRequest;

// By default, the body is constructed for POST and PUT
+ (NSArray *)methodsWithBody;
+ (void)setMethodsWithBody:(NSArray *)requestTypes;

- (void)setValue:(id<IDPSerialization>)value
          forKey:(NSString *)key;

- (void)setObject:(id<IDPSerialization>)anObject
           forKey:(id<NSCopying, IDPSerialization>)aKey;

// this method does the same, as setObject:forKey:
// is mentioned for consistency of subclassing
// and should never be used
- (void)setObject:(id<IDPSerialization>)obj
forKeyedSubscript:(id<NSCopying, IDPSerialization>)key;

// this method is used for overloading in subclasses
// you set the HTTP headers and body in this method
- (void)setHTTPDataForUrlRequest:(NSMutableURLRequest *)request;

@end
