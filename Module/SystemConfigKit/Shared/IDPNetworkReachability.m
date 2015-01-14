//
//  IDPNetworkReachability.m
//  SmartFart
//
//  Created by Oleksa 'trimm' Korin on 1/31/12.
//  Copyright (c) 2012 IDAP Group. All rights reserved.
//

#import "IDPNetworkReachability.h"



#import "IDPPropertyMacros.h"

NSString * const    IDPNetworkReachabilityErrorDomain                           = @"IDPNetworkReachabilityErrorDomain";
NSString * const    IDPNetworkReachabilityErrorInternetNotReachableDescription	= @"Internet connection is absent at the moment. Please, try later.";

const NSInteger     IDPNetworkReachabilityErrorInternetNotReachable             = 1212;

#pragma mark -
#pragma mark -

@interface _IDPNetworkReachabilityAddressKey : NSObject <NSCopying>
@property (nonatomic, assign) struct sockaddr_in address;

+ (id)keyForAddress:(const struct sockaddr_in *)address;

@end

#pragma mark -
#pragma mark -

@implementation _IDPNetworkReachabilityAddressKey

@synthesize address     = _address;

#pragma mark-
#pragma mark Class Methods

+ (id)keyForAddress:(const struct sockaddr_in *)address {
    _IDPNetworkReachabilityAddressKey *key = [self new];
    key.address = *address;
    
    return key;
}

#pragma mark-
#pragma mark Accessors

- (void)setAddress:(struct sockaddr_in)address {
    memcpy(&_address, &address, sizeof(address));
}

#pragma mark-
#pragma mark NSCopying

- (id)copyWithZone:(NSZone *)zone {
    _IDPNetworkReachabilityAddressKey *key = [[self class] new];
    key.address = self.address;
    
    return key;
}

#pragma mark-
#pragma mark Comparison

- (BOOL)isEqual:(id)object {
    _IDPNetworkReachabilityAddressKey *key = (_IDPNetworkReachabilityAddressKey *)object;
    
    struct sockaddr_in source = self.address;
    struct sockaddr_in destination = key.address;
    
    return source.sin_port == destination.sin_port && source.sin_addr.s_addr == destination.sin_addr.s_addr;
}

- (NSUInteger)hash {
    struct sockaddr_in address = self.address;
    
    return ((NSUInteger)address.sin_addr.s_addr ^ (NSUInteger)address.sin_port);
}

@end

#pragma mark -
#pragma mark -

@interface IDPNetworkReachability ()
@property (nonatomic, assign, readwrite) IDPNetworkStatus               status;
@property (nonatomic, assign, readwrite) IDPNetworkReachabilityType     type;

// assign is here, 'cause properties for core data can't be retain synthesized
// still, the property is a retained one
@property (nonatomic, assign, readwrite) SCNetworkReachabilityRef       reachability;

@property (nonatomic, assign, readwrite) NSUInteger                     scheduleCount;

+ (id)reachabilityForKey:(id)key;
+ (void)setReachability:(IDPNetworkReachability *)reachability forKey:(id)key;

- (void)updateReachabilityStatusWithFlags:(SCNetworkReachabilityFlags)flags;
- (IDPNetworkStatus)localWiFiStatusForFlags:(SCNetworkReachabilityFlags)flags;
- (IDPNetworkStatus)networkStatusForFlags:(SCNetworkReachabilityFlags)flags;

@end

static void IDPNetworkReachabilitySatusChangedCallback(SCNetworkReachabilityRef target, SCNetworkReachabilityFlags flags, void *info) {
    @autoreleasepool {
        IDPNetworkReachability *reachability = (__bridge IDPNetworkReachability *)info;
        // Post a notification to notify the client that the network reachability changed.
        [reachability updateReachabilityStatusWithFlags:flags];
    }
}

static NSMutableDictionary  *__reachabilities__ = nil;

#pragma mark -
#pragma mark -

@implementation IDPNetworkReachability

@synthesize status                  = _status;
@synthesize type                    = _type;
@synthesize reachability            = _reachability;
@synthesize scheduleCount           = _scheduleCount;

@dynamic connectionRequired;
@dynamic scheduled;
@dynamic reachable;

#pragma mark -
#pragma mark Class Methods

+ (void)load {
    __reachabilities__ = [[NSMutableDictionary alloc] init];
    
    [super load];
}

+ (id)reachabilityForKey:(id)key {
    return [__reachabilities__ objectForKey:key];
}

+ (void)setReachability:(IDPNetworkReachability *)reachability forKey:(id)key {
    [__reachabilities__ setObject:reachability forKey:key];
}

+ (id)reachability {
    struct sockaddr_in zeroAddress;
	bzero(&zeroAddress, sizeof(zeroAddress));
	zeroAddress.sin_len = sizeof(zeroAddress);
	zeroAddress.sin_family = AF_INET;
    
	return [self reachabilityWithHostAddress:&zeroAddress];
}

+ (id)reachabilityWithHostName:(NSString *)hostName {
    IDPNetworkReachability *result = [self reachabilityForKey:hostName];
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, [hostName UTF8String]);

    if (nil == result) {
        result = [self reachabilityWithRef:reachability ofType:IDPWWANNetworkReachability];
        
        [self setReachability:result forKey:hostName];
    }
    
    SCNetworkReachabilityFlags flags;
    if (SCNetworkReachabilityGetFlags(reachability, &flags)) {
        [result updateReachabilityStatusWithFlags:flags];
    }

    CFRelease(reachability);

    
	return result;
}

+ (id)reachabilityWithHostAddress:(const struct sockaddr_in *)hostAddress {
    _IDPNetworkReachabilityAddressKey *key = [_IDPNetworkReachabilityAddressKey keyForAddress:hostAddress];
    IDPNetworkReachability *result = [self reachabilityForKey:key];
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr *)hostAddress);
    
    if (nil == result) {
        result = [self reachabilityWithRef:reachability ofType:IDPWWANNetworkReachability];
        
        [self setReachability:result forKey:key];
    }
    
    SCNetworkReachabilityFlags flags;
    if (SCNetworkReachabilityGetFlags(reachability, &flags)) {
        [result updateReachabilityStatusWithFlags:flags];
    }
    
    CFRelease(reachability);

    
	return result;
}

+ (id)reachabilityWithRef:(SCNetworkReachabilityRef)reachability
                   ofType:(IDPNetworkReachabilityType)type
{
    IDPNetworkReachability *result = NULL;
    
    if (NULL != reachability) {
		result = [self new];
        
		result.reachability = reachability;
        result.type = type;
	}

    return result;
}

+ (id)reachabilityForLocalWiFi {
    struct sockaddr_in localWifiAddress;
	bzero(&localWifiAddress, sizeof(localWifiAddress));
	localWifiAddress.sin_len = sizeof(localWifiAddress);
	localWifiAddress.sin_family = AF_INET;
	localWifiAddress.sin_addr.s_addr = htonl(IN_LINKLOCALNETNUM);
    
	IDPNetworkReachability *result = [self reachabilityWithHostAddress:&localWifiAddress];
    result.type = IDPWiFiNetworkReachability;
    
	return result;
}

#pragma mark -
#pragma mark Initalizations and Deallocations

- (void)dealloc {
    [self unshedule];
    self.reachability = NULL;
}

#pragma mark -
#pragma mark Accessors

- (void)setReachability:(SCNetworkReachabilityRef)reachability {
    if (NULL != _reachability) {
        CFRelease(_reachability);
    }
    
    IDPNonatomicAssignPropertySynthesize(_reachability, reachability);
    
    if (NULL != _reachability) {
        CFRetain(_reachability);
    }
}

- (BOOL)isConnectionRequired {
	SCNetworkReachabilityFlags flags;
	if (SCNetworkReachabilityGetFlags(self.reachability, &flags)) {
		return (flags & kSCNetworkReachabilityFlagsConnectionRequired);
	}
    
	return NO;
}

- (BOOL)isScheduled {
    return (0 != self.scheduleCount);
}

- (BOOL)isReachable {
    return IDPNetworkReachableViaWiFi == self.status
    || IDPNetworkReachableViaWWAN == self.status;
}

#pragma mark -
#pragma mark Public

- (BOOL)schedule {
    if (self.scheduled) {
        self.scheduleCount += self.scheduleCount;
        return YES;
    }
    
    BOOL result = NO;
    
    SCNetworkReachabilityRef reachability = self.reachability;
	SCNetworkReachabilityContext context = {0, (__bridge void *)(self), NULL, NULL, NULL};
    
	if (SCNetworkReachabilitySetCallback(reachability, IDPNetworkReachabilitySatusChangedCallback, &context)) {
		result = SCNetworkReachabilityScheduleWithRunLoop(reachability, CFRunLoopGetMain(), kCFRunLoopDefaultMode);
        self.scheduleCount += self.scheduleCount;
	}
    
	return result;
}

- (void)unshedule {
    self.scheduleCount -= self.scheduleCount;
    
    if (!self.scheduled) {
        SCNetworkReachabilityUnscheduleFromRunLoop(self.reachability, CFRunLoopGetMain(), kCFRunLoopDefaultMode);
    }
}

#pragma mark -
#pragma mark Private

- (void)updateReachabilityStatusWithFlags:(SCNetworkReachabilityFlags)flags {
    IDPNetworkStatus result = IDPNetworkNotReachable;

    if (IDPWiFiNetworkReachability == self.type) {
        result = [self localWiFiStatusForFlags:flags];
    } else {
        result = [self networkStatusForFlags:flags];
    }

    self.status = result;
}

- (IDPNetworkStatus)localWiFiStatusForFlags:(SCNetworkReachabilityFlags)flags {
	BOOL result = IDPNetworkNotReachable;
	if((flags & kSCNetworkReachabilityFlagsReachable) && (flags & kSCNetworkReachabilityFlagsIsDirect)) {
		result = IDPNetworkReachableViaWiFi;
	}
    
	return result;
}

- (IDPNetworkStatus)networkStatusForFlags:(SCNetworkReachabilityFlags)flags {
	if ((flags & kSCNetworkReachabilityFlagsReachable) == 0) {
		// if target host is not reachable
		return IDPNetworkNotReachable;
	}

	BOOL result = IDPNetworkNotReachable;
	
	if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0) {
		// if target host is reachable and no connection is required
		//  then we'll assume (for now) that your on Wi-Fi
		result = IDPNetworkReachableViaWiFi;
	}
	
	
	if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||
		(flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0))
	{
			// ... and the connection is on-demand (or on-traffic) if the
			//     calling application is using the CFSocketStream or higher APIs

			if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0) {
				// ... and no [user] intervention is needed
				result = IDPNetworkReachableViaWiFi;
			}
	}
	
#if TARGET_OS_IPHONE
	if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN) {
		// ... but WWAN connections are OK if the calling application
		//     is using the CFNetwork (CFSocketStream?) APIs.
		result = IDPNetworkReachableViaWWAN;
	}
#endif
    
	return result;
}

@end
