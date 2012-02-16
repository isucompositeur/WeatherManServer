//
//  WXSocket.h
//  WeatherManServer
//
//  Created by Nicholas Meyer on 2/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXSocket : NSObject {
    
    CFSocketRef *socket;
    NSInputStream *inputStream;
    NSOutputStream *outputStream;
    NSTimeInterval soTimeout;
    BOOL tcpNoDelay;
    int localPort, port;
    NSHost *localHost, *host;
    
}

@property(readonly,atomic) NSInputStream *inputStream;
@property(readonly,atomic) NSOutputStream *outputStream;
@property(assign,atomic) NSTimeInterval soTimeout;
@property(assign,atomic) BOOL tcpNoDelay;
@property(readonly,atomic) NSHost *localHost;
@property(readonly,atomic) NSHost *host;
@property(readonly,atomic) int localPort;
@property(readonly,atomic) int port;

- (void)close;
- (void)setSoLinger:(BOOL)linger length:(NSTimeInterval)length;
- (NSTimeInterval)soLinger;

@end
