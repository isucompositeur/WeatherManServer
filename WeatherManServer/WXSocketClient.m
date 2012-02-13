//
//  WXSocketClient.m
//  WeatherManServer
//
//  Created by Nicholas Meyer on 2/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WXSocketClient.h"
#import "WXDefaultSocketFactory.h"

// The end of line character sequence used by most IETF protocols.  That
// is a carriage return followed by a newline: "\r\n"
NSString * const WXSOCKETCLIENT_NETASCII_EOL = @"\r\n";

// The default SocketFactory shared by all SocketClient instances.
static id<WXSocketFactory> __DEFAULT_SOCKET_FACTORY = nil;

@interface WXSocketClient()

- (void)_connectAction_:(NSError **)error;

@end

@implementation WXSocketClient 

@synthesize _isConnected_,_defaultPort_,_timeout_;

+ (void)initialize
{
    // Create a socket factory if one doesn't exist
    if (!__DEFAULT_SOCKET_FACTORY) {
        __DEFAULT_SOCKET_FACTORY = [[WXDefaultSocketFactory alloc] init];
    }
}

/*
 * Default constructor for SocketClient.  Initializes
 * _socket_ to null, _timeout_ to 0, _defaultPort to 0,
 * _isConnected_ to false, and _socketFactory_ to a shared instance of
 * DefaultSocketFactory.
 */
- (id)init
{
    self = [super init];
    if (self) {
        _socket_ = NULL;
        _input_ = NULL;
        _output_ = NULL;
        _timeout_ = 0;
        _defaultPort_ = 0;
        _isConnected_ = NO;
        _socketFactory_ = __DEFAULT_SOCKET_FACTORY;
    }
    return self;
}

/*
 * Because there are so many connect: methods, the _connectAction_
 * method is provided as a means of performing some action immediately
 * after establishing a connection, rather than reimplementing all
 * of the connect: methods.  The last action performed by every
 * connect: method after opening a socket is to call this method.
 * 
 * This method sets the timeout on the just opened socket to the default
 * timeout set by setDefaultTimeout:,
 * sets _input_ and _output_ to the socket's InputStream and OutputStream
 * respectively, and sets _isConnected_ to true.
 * 
 * Subclasses overriding this method should start by calling
 * [super _connectAction_:] first to ensure the
 * initialization of the aforementioned protected variables.
 */
- (void)_connectAction_:(NSError **)error;
{
    _socket_.socketTimeout = _timeout_;
    _input_ = _socket_.inputStream;
    _output_ = _socket_.outputStream;
    _isConnected_ = YES;    
}

/*
 * Opens a Socket connected to a remote host at the specified port and
 * originating from the current host at a system assigned port.
 * Before returning, [self _connectAction_:]
 * is called to perform connection initialization actions.
 */
- (void)connectToHost:(NSString *)remoteHost toPort:(int)remotePort error:(NSError **)error
{
    _socket_ = [_socketFactory_ createSocketToHost:remoteHost toPort:remotePort error:error];
    [self _connectAction_:error];
}

/*
 * Opens a Socket connected to a remote host at the specified port and
 * originating from the specified local address and port.
 * Before returning, [self _connectAction_:]
 * is called to perform connection initialization actions.
 */
- (void)connectToHost:(NSString *)remoteHost toPort:(int)remotePort fromAddress:(NSString *)localAddr fromPort:(int)localPort error:(NSError **)error
{
    _socket_ = [_socketFactory_ createSocketToHost:remoteHost toPort:remotePort fromAddress:localAddr fromPort:localPort error:error];
    [self _connectAction_:error];
}

/*
 * Opens a Socket connected to a remote host at the current default port
 * and originating from the current host at a system assigned port.
 * Before returning, [self _connectAction_:]
 * is called to perform connection initialization actions.
 */

- (void)connectToHost:(NSString *)remoteHost error:(NSError **)error
{
    _socket_ = [_socketFactory_ createSocketToHost:remoteHost toPort:_defaultPort_ error:error];
    [self _connectAction_:error];
}

/**
 * Disconnects the socket connection.
 * You should call this method after you've finished using the class
 * instance and also before you call
 * [self connect:]
 * again.  _isConnected_ is set to false, _socket_ is set to null,
 * _input_ is set to null, and _output_ is set to null.
 */
- (void)disconnect:(NSError **)error
{
    [_socket_ close:error];
    [_output_ close];
    [_input_ close];
    _socket_ = nil;
    _input_ = nil;
    _output_ = nil;
    _isConnected_ = NO;    
}




@end
