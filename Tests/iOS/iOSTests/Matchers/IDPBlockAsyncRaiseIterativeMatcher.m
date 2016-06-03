//
//  IDPBlockAsyncRaiseIterativeMatcher.m
//  iOS
//
//  Created by Oleksa Korin on 19/1/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "IDPBlockAsyncRaiseIterativeMatcher.h"

#import "KWBlock.h"

@interface IDPBlockAsyncRaiseIterativeMatcher ()
@property (nonatomic, assign)   NSUInteger          iterationCount;
@property (nonatomic, strong)   dispatch_group_t    dispatchGroup;
@property (nonatomic, strong)   dispatch_queue_t    dispatchQueue;

@property (atomic, readwrite, strong) NSException   *exception;
@property (atomic, readwrite, strong) NSException   *actualException;

- (BOOL)checkResult;
- (void)performIterativeAsync;

@end

@implementation IDPBlockAsyncRaiseIterativeMatcher

#pragma mark -
#pragma mark Class Methods

+ (NSArray *)matcherStrings {
    return @[@"raiseWithIterationCount:",
             @"raiseWithName:iterationCount:",
             @"raiseWithReason:iterationCount:",
             @"raiseWithName:reason:iterationCount:"];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (id)initWithSubject:(id)anObject {
    self = [super initWithSubject:anObject];
    if (self) {
        self.iterationCount = 1;
        self.dispatchGroup = dispatch_group_create();
        
        NSString *name = [NSString stringWithFormat:@"com.idpkit.queue.%@",
                          [NSStringFromClass([self class]) lowercaseString]];
        self.dispatchQueue = dispatch_queue_create([name cStringUsingEncoding:NSUTF8StringEncoding],
                                                       DISPATCH_QUEUE_CONCURRENT);
    }
    
    return self;
}

#pragma mark -
#pragma Public

- (BOOL)evaluate {
    if (![self.subject isKindOfClass:[KWBlock class]]) {
        [NSException raise:@"KWMatcherException" format:@"subject must be a KWBlock"];
    }
    
    [self performIterativeAsync];
    
    return [self checkResult];
}

- (void)raiseWithIterationCount:(NSUInteger)count {
    [self raiseWithName:nil reason:nil iterationCount:count];
}

- (void)raiseWithName:(NSString *)aName
       iterationCount:(NSUInteger)count
{
    [self raiseWithName:aName reason:nil iterationCount:count];
}

- (void)raiseWithReason:(NSString *)aReason
         iterationCount:(NSUInteger)count
{
    [self raiseWithName:nil reason:aReason iterationCount:count];
}

- (void)raiseWithName:(NSString *)aName
               reason:(NSString *)aReason
       iterationCount:(NSUInteger)count
{
    self.iterationCount = count;
    
    [super raiseWithName:aName reason:aReason];
}

#pragma mark -
#pragma Private

- (BOOL)checkResult {
    NSException *actualException = self.actualException;
    NSException *exception = self.exception;
    if (actualException) {
        if ([exception name] != nil
            && ![[exception name] isEqualToString:[actualException name]])
        {
            return NO;
        }
        
        if ([exception reason] != nil
            && ![[exception reason] isEqualToString:[actualException reason]])
        {
            return NO;
        }
        
        return YES;
    }
    
    return NO;
}

- (void)performIterativeAsync {
    dispatch_queue_t queue = self.dispatchQueue;
    dispatch_group_t group = self.dispatchGroup;
    
    NSUInteger count = self.iterationCount;
    for (NSUInteger i = 0; i < count; i++) {
        dispatch_group_async(group,
                             queue,
                             ^{
                                 @autoreleasepool {
                                     if (self.actualException) {
                                         return;
                                     }
                                     
                                     @try {
                                         [self.subject call];
                                     }
                                     @catch (id exception) {
                                         self.actualException = exception;
                                     }
                                 }
                             });
    }
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
}

@end
