//
//  WXSocketClient.h
//  WeatherManServer
//
//  Created by Nicholas Meyer on 2/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXSocketFactory.h"
#import "WXSocket.h"

extern NSString * const WXSOCKETCLIENT_NETASCII_EOL;

@interface WXSocketClient : NSObject {
    
    // The timeout to use after opening a socket.
    NSTimeInterval _timeout_;
    
    // The socket used for the connection.
    WXSocket *_socket_;
    
    // A status variable indicating if the client's socket is currently open.
    bool _isConnected_;
    
    // The default port the client should connect to.
    int _defaultPort_;
    
    // The socket's InputStream.
    NSInputStream *_input_;
    
    // The socket's OutputStream.
    NSOutputStream *_output_;
    
    // The socket's SocketFactory.
    id<WXSocketFactory> _socketFactory_;
    
}

@property(readonly,atomic,getter=isConnected) bool _isConnected_;
@property(assign,atomic,getter=defaultPort,setter=setDefaultPort:) int _defaultPort_;
@property(assign,atomic,getter=defaultTimeout,setter=setDefaultTimeout:) NSTimeInterval _timeout_;

- (void)connectToHost:(NSString *)remoteHost toPort:(int)remotePort error:(NSError **)error;
- (void)connectToHost:(NSString *)remoteHost toPort:(int)remotePort fromAddress:(NSString *)localAddr fromPort:(int)localPort error:(NSError **)error;
- (void)connectToHost:(NSString *)remoteHost error:(NSError **)error;
- (void)disconnect:(NSError **)error;
- (void)setSocketTimeout:(NSTimeInterval)timeout error:(NSError **)error;
- (NSTimeInterval)socketTimeout:(NSError **)error;

@end
