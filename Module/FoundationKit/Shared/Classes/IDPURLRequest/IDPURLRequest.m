//
//  IDPURLRequest.m
//  IDPKit
//
//  Created by Oleksa 'trimm' Korin on 5/25/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPURLRequest.h"

#import <objc/runtime.h>

#import "NSString+IDPExtensions.h"

NSString * const IDPRequestTypeGET      = @"GET";
NSString * const IDPRequestTypePOST     = @"POST";
NSString * const IDPRequestTypePUT      = @"PUT";
NSString * const IDPRequestTypeDELETE   = @"DELETE";

static NSString * kIDPURLRequestBodyTypes               = @"kIDPURLRequestBodyTypes";
static NSString * kIDPURLRequestPathRoot                = @"/";
static NSString * kIDPURLRequestPathSeparator           = @"?";
static NSString * kIDPURLRequestParameterSeparator      = @"&";


static NSTimeInterval kkIDPURLRequestDefaultTimeout     = 60.0;

@interface IDPURLRequest ()

- (BOOL)isMethodWithBody:(NSString *)requestType;
- (NSString *)parameterString;
- (NSString *)requestStringWithURLString:(NSString *)urlString;

@end

@implementation IDPURLRequest

@synthesize host                    = _host;
@synthesize path                    = _path;
@synthesize pathSeparator           = _pathSeparator;
@synthesize parameterSeparator      = _parameterSeparator;
@synthesize method                  = _method;

@dynamic urlRequest;

#pragma mark -
#pragma mark Class Methods

+ (void)initialize {
    if (self == [IDPURLRequest class]) {
        [self setMethodsWithBody:[NSArray arrayWithObjects:IDPRequestTypePOST, IDPRequestTypePUT, nil]];
    }
}

+ (NSArray *)methodsWithBody {
    return objc_getAssociatedObject(self,
                                    kIDPURLRequestBodyTypes);
}

+ (void)setMethodsWithBody:(NSArray *)requestTypes {
    objc_setAssociatedObject(self,
                             kIDPURLRequestBodyTypes,
                             requestTypes,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.host = nil;
    self.path = nil;
    self.pathSeparator = nil;
    self.parameterSeparator = nil;
    self.method = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Accessors

- (NSMutableURLRequest *)urlRequest {
    NSString *urlString = self.path;
    BOOL bodyType = [self isMethodWithBody:self.method];
    
    if (!bodyType) {
        urlString = [self requestStringWithURLString:urlString];
    }
    
    NSURL *url = [NSURL URLWithString:urlString
						relativeToURL:[NSURL URLWithString:self.host]];
    
    NSMutableURLRequest *result = [NSMutableURLRequest requestWithURL:url];
    result.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    result.timeoutInterval = kkIDPURLRequestDefaultTimeout;
    result.HTTPMethod = self.method;
    
    if (bodyType) {
        [self setHTTPDataForUrlRequest:result];
    }
    
    return result;
}

- (NSString *)path {
    if (nil == _path) {
        return kIDPURLRequestPathRoot;
    }
    
    return [[_path retain] autorelease];
}

- (NSString *)pathSeparator {
    if (nil == _pathSeparator) {
        return kIDPURLRequestPathSeparator;
    }
    
    return [[_pathSeparator retain] autorelease];
}

- (NSString *)parameterSeparator {
    if (nil == _parameterSeparator) {
        return kIDPURLRequestParameterSeparator;
    }
    
    return [[_parameterSeparator retain] autorelease];
}

#pragma mark -
#pragma mark Public

- (void)setValue:(id<IDPSerialization>)value
          forKey:(NSString *)key
{
    [super setValue:value forKey:key];
}

- (void)setObject:(id<IDPSerialization>)anObject
           forKey:(id<NSCopying, IDPSerialization>)aKey
{
    [super setObject:anObject forKey:aKey];
}

- (void)setObject:(id<IDPSerialization>)obj
forKeyedSubscript:(id<NSCopying, IDPSerialization>)key
{
    [self setObject:obj forKey:key];
}

#pragma mark -
#pragma mark Private

- (BOOL)isMethodWithBody:(NSString *)method {
    return [[[self class] methodsWithBody] containsObject:method];
}

- (NSString *)parameterString {
    NSMutableString *result = [NSMutableString string];
    
    for (id<IDPSerialization> key in [self allKeys]) {
        id<IDPSerialization> value = [self objectForKey:key];
        [result appendFormat:@"%@%@=%@",
            self.parameterSeparator,
            [[key serialize] urlEncode],
            [[value serialize] urlEncode]];
    }
    
    if ([result length] > 0) {
        [result deleteCharactersInRange:NSMakeRange(0, 1)];
    }
    
    return [NSString stringWithString:result];
}

- (NSString *)requestStringWithURLString:(NSString *)urlString {
    return [NSString stringWithFormat:@"%@%@%@", urlString, self.pathSeparator, [self parameterString]];
}

- (void)setHTTPDataForUrlRequest:(NSMutableURLRequest *)request {
    NSString *parameterString = [self parameterString];
    NSData *body = [parameterString dataUsingEncoding:NSUTF8StringEncoding];

    [request setHTTPBody:body];
    
    [request setValue:@"application/x-www-form-urlencoded"
   forHTTPHeaderField:@"Content-Type"];
    
    [request setValue:[NSString stringWithFormat:@"%d", [parameterString length]]
   forHTTPHeaderField:@"Content-Length"];
}

@end
