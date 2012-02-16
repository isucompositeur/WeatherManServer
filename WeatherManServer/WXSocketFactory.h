//
//  WXSocketFactory.h
//  WeatherManServer
//
//  Created by Nicholas Meyer on 2/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXSocket.h"
#import "WXServerSocket.h"

@protocol WXSocketFactory <NSObject>

- (WXSocket *) createSocketToHost:(NSString *)remoteHost toPort:(int)remotePort;
- (WXSocket *) createSocketToHost:(NSString *)remoteHost toPort:(int)remotePort fromAddress:(NSString *)localAddr fromPort:(int)localPort;

- (WXServerSocket *)createServerSocketForPort:(int)port;
- (WXServerSocket *)createServerSocketForPort:(int)port withBacklog:(int)backlogr;
- (WXServerSocket *)createServerSocketForPort:(int)port withBacklog:(int)backlog forAddress:(NSString *)addr;


@end
