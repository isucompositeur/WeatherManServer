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

- (WXSocket *) createSocketToHost:(NSString *)remoteHost toPort:(int)remotePort error:(NSError **)error;
- (WXSocket *) createSocketToHost:(NSString *)remoteHost toPort:(int)remotePort fromAddress:(NSString *)localAddr fromPort:(int)localPort error:(NSError **)error;

- (WXServerSocket *)createServerSocketForPort:(int)port error:(NSError **)error;
- (WXServerSocket *)createServerSocketForPort:(int)port withBacklog:(int)backlog error:(NSError **)error;
- (WXServerSocket *)createServerSocketForPort:(int)port withBacklog:(int)backlog forAddress:(NSString *)addr;


@end
