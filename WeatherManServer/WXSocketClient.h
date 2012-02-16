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
    BOOL _isConnected_;
    
    // The default port the client should connect to.
    int _defaultPort_;
    
    // The socket's InputStream.
    NSInputStream *_input_;
    
    // The socket's OutputStream.
    NSOutputStream *_output_;
    
    // The socket's SocketFactory.
    id<WXSocketFactory> _socketFactory_;
    
}


@property(readonly,atomic,getter=isConnected) BOOL _isConnected_;
@property(assign,atomic,getter=defaultPort,setter=setDefaultPort:) int _defaultPort_;
@property(assign,atomic,getter=defaultTimeout,setter=setDefaultTimeout:) NSTimeInterval _timeout_;

- (void)connectToHost:(NSString *)remoteHost toPort:(int)remotePort;
- (void)connectToHost:(NSString *)remoteHost toPort:(int)remotePort fromAddress:(NSString *)localAddr fromPort:(int)localPort;
- (void)connectToHost:(NSString *)remoteHost;
- (void)disconnect;
- (void)setSoTimeout:(NSTimeInterval)timeout;
- (NSTimeInterval)soTimeout;
- (void)setTcpNoDelay:(BOOL)on;
- (BOOL)tcpNoDelay;
- (void)setSoLinger:(BOOL)linger length:(NSTimeInterval)length;
- (NSTimeInterval)soLinger;
- (int)localPort;
- (NSHost *)localHost;
- (int)remotePort;
- (NSHost *)remoteHost;
- (BOOL)verifyRemote:(WXSocket *)socket;
- (void)setSocketFactory:(id<WXSocketFactory>)socketFactory;

@end
