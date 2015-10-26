//
//  NetWorkUtils.m
//  SCUtility
//
//  Created by Jarry on 14-5-5.
//  Copyright (c) 2014年 Jarry. All rights reserved.
//

#import "NetWorkUtils.h"
#import "SCMacroDefines.h"
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <arpa/inet.h>
#include <ifaddrs.h>
#import <SystemConfiguration/CaptiveNetwork.h>

@implementation NetWorkUtils

#pragma mark - Network Status

+ (BOOL) IsNetworkAvailable
{
    return ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable);
}

+ (BOOL) IsWIFIEnabled
{
    return ([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable);
}

+ (BOOL) Is3GEnabled
{
    return ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == ReachableViaWWAN);
}

#pragma mark - IP Address

+ (NSString *) localIPAddress
{
    NSString *localIP = nil;
    struct ifaddrs *addrs;
    if (getifaddrs(&addrs)==0) {
        const struct ifaddrs *cursor = addrs;
        while (cursor != NULL) {
            if (cursor->ifa_addr->sa_family == AF_INET && (cursor->ifa_flags & IFF_LOOPBACK) == 0)
            {
                NSString *name = [NSString stringWithUTF8String:cursor->ifa_name];
                if ([name isEqualToString:@"en0"]) // Wi-Fi adapter
                {
                    localIP = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)];
                    break;
                }
                localIP = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)];
            }
            cursor = cursor->ifa_next;
        }
        freeifaddrs(addrs);
    }
    return localIP;
}

+ (NSString *) broadcastAddress:(NSString *)ipAddr mask:(NSString *)netMask
{
    NSMutableString *broadcastAddr = [NSMutableString string];
    
    NSArray *ips = [ipAddr componentsSeparatedByString:@"."];
    NSArray *masks = [netMask componentsSeparatedByString:@"."];
    
    for (int i=0; i<ips.count; i++) {
        
        UInt8 t1 = [[ips objectAtIndex:i] intValue];
        UInt8 t2 = ~[[masks objectAtIndex:i] intValue];
        UInt8 t = t1 | t2;
        
        [broadcastAddr appendString:kIntToString(t)];
        if (i < ips.count-1) {
            [broadcastAddr appendString:@"."];
        }
    }
    
    return broadcastAddr;
}

#pragma mark - MAC

+ (NSString *) macAddress
{
	int                 mib[6];
	size_t              len;
	char                *buf;
	unsigned char       *ptr;
	struct if_msghdr    *ifm;
	struct sockaddr_dl  *sdl;
	
	mib[0] = CTL_NET;
	mib[1] = AF_ROUTE;
	mib[2] = 0;
	mib[3] = AF_LINK;
	mib[4] = NET_RT_IFLIST;
	
	if ((mib[5] = if_nametoindex("en0")) == 0) {
		NSLog(@"Error: if_nametoindex error/n");
		return NULL;
	}
	
	if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
		NSLog(@"Error: sysctl, take 1/n");
		return NULL;
	}
	
	if ((buf = malloc(len)) == NULL) {
		NSLog(@"Error: Could not allocate memory!/n");
		return NULL;
	}
	
	if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
		NSLog(@"Error: sysctl, take 2");
		return NULL;
	}
	
	ifm = (struct if_msghdr *)buf;
	sdl = (struct sockaddr_dl *)(ifm + 1);
	ptr = (unsigned char *)LLADDR(sdl);
	// NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
	NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
	free(buf);
	return [outstring uppercaseString];
	
}

#pragma mark - SSID

+ (id) fetchSSIDInfo
{
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    id info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
//        NSLog(@"%@ => %@", ifnam, info);
        if (info && [info count]) { break; }
    }
    return info;
}


@end
