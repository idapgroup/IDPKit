//
//  RSLDownloadConnection.h
//  MolaMagic
//
//  Created by Oleksa 'trimm' Korin on 4/14/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPModel.h"
#import "IDPURLRequest.h"

@interface IDPURLConnection : IDPModel

// the url the connection connects to
@property (nonatomic, readonly)     NSURL           *url;

// immutable url request the connection would use
@property (nonatomic, readonly)     NSURLRequest    *urlRequest;

// the response data
@property (nonatomic, readonly)     NSData          *data;
// response string
@property (nonatomic, readonly)     NSString        *string;

// the error raised, if the connection fails
// conforms to NSURLConnection errors
@property (nonatomic, readonly)     NSError         *error;

+ (id)connectionToURL:(NSURL *)url;
+ (id)connectionWithRequest:(NSURLRequest *)urlRequest;

- (void)cleanup;

@end
