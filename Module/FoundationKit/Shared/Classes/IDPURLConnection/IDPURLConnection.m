//
//  RSLDownloadConnection.m
//  MolaMagic
//
//  Created by Oleksa 'trimm' Korin on 4/14/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPURLConnection.h"

#import "NSObject+IDPExtensions.h"

#import "IDPPropertyMacros.h"

@interface IDPURLConnection () <NSURLConnectionDelegate>

@property (nonatomic, copy, readwrite)      NSURLRequest    *urlRequest;
@property (nonatomic, retain, readwrite)    NSError         *error;

@property (nonatomic, retain)    NSMutableData              *mutableData;
@property (nonatomic, retain)    NSURLConnection            *connection;

@end

@implementation IDPURLConnection

@synthesize urlRequest      = _urlRequest;
@synthesize error           = _error;
@synthesize mutableData     = _mutableData;
@synthesize connection      = _connection;

@dynamic url;
@dynamic data;
@dynamic string;

#pragma mark -
#pragma mark Class Methods

+ (id)connectionToURL:(NSURL *)url {
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    return [self connectionWithRequest:request];
}

+ (id)connectionWithRequest:(NSURLRequest *)urlRequest {
    IDPURLConnection *result = [IDPURLConnection object];
    result.urlRequest = urlRequest;
    result.mutableData = [NSMutableData data];
    
    return result;
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.urlRequest = nil;
    self.error = nil;
    self.mutableData = nil;
    self.connection = nil;
    
	[super dealloc];
}

#pragma mark -
#pragma mark Accessors

- (NSURL *)url {
    return self.urlRequest.URL;
}

- (void)setConnection:(NSURLConnection *)connection {
    if (connection != _connection) {
        [_connection cancel];
    }
    
    IDPNonatomicRetainPropertySynthesize(_connection, connection);
}

- (NSData *)data {
    return [NSData dataWithData:self.mutableData];
}

- (NSString *)string {
    NSString *result = [[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding];
    return [result autorelease];
}

#pragma mark -
#pragma mark Public

- (BOOL)load {
    if (![super load]) {
        return NO;
    }

	self.connection = [NSURLConnection connectionWithRequest:self.urlRequest
                                                    delegate:self];
    
    return YES;
}

- (void)cleanup {
    self.error = nil;
    self.mutableData = nil;
    self.connection = nil;
}

#pragma mark -
#pragma mark NSURLConnectionDelegate methods

- (void)connection:(NSURLConnection *)connection
didReceiveResponse:(NSURLResponse *)response {
    if (connection == self.connection)
    {
		// this method is called when the server has determined that it
		// has enough information to create the NSURLResponse
        self.mutableData.length = 0;
	}
}

- (void)connection:(NSURLConnection *)connection
    didReceiveData:(NSData *)data
{
    if (connection == self.connection) {
		// append the new data to the receivedData
		[self.mutableData appendData:data];
	}
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    if (connection == self.connection) {
        [self failLoading];
	}
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if (connection == self.connection) {
        [self finishLoading];
	}
}

@end
