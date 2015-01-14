//
//  IDPNetworkReachability.h
//  SmartFart
//
//  Created by Oleksa 'trimm' Korin on 1/31/12.
//  Copyright (c) 2012 IDAP Group. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <netinet6/in6.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
#import <netdb.h>

#import <CoreFoundation/CoreFoundation.h>

extern NSString * const IDPNetworkReachabilityErrorDomain;
extern NSString * const IDPNetworkReachabilityErrorInternetNotReachableDescription;
extern const NSInteger  IDPNetworkReachabilityErrorInternetNotReachable;

typedef enum {
	IDPNetworkNotReachable,
	IDPNetworkReachableViaWiFi,
	IDPNetworkReachableViaWWAN
} IDPNetworkStatus;

typedef enum {
	IDPWiFiNetworkReachability,
	IDPWWANNetworkReachability
} IDPNetworkReachabilityType;

@interface IDPNetworkReachability: NSObject
// observable
@property (nonatomic, readonly) IDPNetworkStatus            status;
@property (nonatomic, readonly) IDPNetworkReachabilityType  type;
@property (nonatomic, readonly) SCNetworkReachabilityRef    reachability;

// count of objects, who scheduled the reachability
@property (nonatomic, readonly) NSUInteger                  scheduleCount;

// Depends on the reachability kind
// WWAN may be available, but not active until a connection has been established.
// WiFi may require a connection for VPN on Demand.
@property (nonatomic, readonly, getter = isConnectionRequired)  BOOL     connectionRequired;
@property (nonatomic, readonly, getter = isScheduled)           BOOL     scheduled;

@property (nonatomic, readonly, getter = isReachable)           BOOL     reachable;

// default reachability for internet conenction
+ (id)reachability;
+ (id)reachabilityWithHostName:(NSString *)hostName;
+ (id)reachabilityWithHostAddress:(const struct sockaddr_in *)hostAddress;
+ (id)reachabilityWithRef:(SCNetworkReachabilityRef)reachabilityRef ofType:(IDPNetworkReachabilityType)type;

+ (id)reachabilityForLocalWiFi;

// schedules on main runloop
- (BOOL)schedule;

// unshedules from the main loop scheduleCount == 0
- (void)unshedule;

@end


