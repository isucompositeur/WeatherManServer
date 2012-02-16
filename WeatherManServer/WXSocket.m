//
//  WXSocket.m
//  WeatherManServer
//
//  Created by Nicholas Meyer on 2/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WXSocket.h"

@implementation WXSocket

@synthesize inputStream,outputStream,soTimeout,tcpNoDelay,localPort,port,localHost,host;

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)close
{
    
}

- (void)setSoLinger:(BOOL)linger length:(NSTimeInterval)length
{
    
}

- (NSTimeInterval)soLinger
{
    return 0;
}

@end
