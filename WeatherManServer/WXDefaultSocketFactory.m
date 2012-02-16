//
//  WXDefaultSocketFactory.m
//  WeatherManServer
//
//  Created by Nicholas Meyer on 2/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WXDefaultSocketFactory.h"

@implementation WXDefaultSocketFactory

- (WXSocket *) createSocketToHost:(NSString *)remoteHost toPort:(int)remotePort
{
    return nil;
}
- (WXSocket *) createSocketToHost:(NSString *)remoteHost toPort:(int)remotePort fromAddress:(NSString *)localAddr fromPort:(int)localPort
{
    return nil;
}

- (WXServerSocket *)createServerSocketForPort:(int)port
{
    return nil;
}
- (WXServerSocket *)createServerSocketForPort:(int)port withBacklog:(int)backlog
{
    return nil;
}
- (WXServerSocket *)createServerSocketForPort:(int)port withBacklog:(int)backlog forAddress:(NSString *)addr
{
    return nil;
}


@end
