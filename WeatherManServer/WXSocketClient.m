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

- (void)_connectAction_;

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
- (void)_connectAction_;
{
    _socket_.soTimeout = _timeout_;
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
- (void)connectToHost:(NSString *)remoteHost toPort:(int)remotePort
{
    _socket_ = [_socketFactory_ createSocketToHost:remoteHost toPort:remotePort];
    [self _connectAction_];
}

/*
 * Opens a Socket connected to a remote host at the specified port and
 * originating from the specified local address and port.
 * Before returning, [self _connectAction_:]
 * is called to perform connection initialization actions.
 */
- (void)connectToHost:(NSString *)remoteHost toPort:(int)remotePort fromAddress:(NSString *)localAddr fromPort:(int)localPort
{
    _socket_ = [_socketFactory_ createSocketToHost:remoteHost toPort:remotePort fromAddress:localAddr fromPort:localPort];
    [self _connectAction_];
}

/*
 * Opens a Socket connected to a remote host at the current default port
 * and originating from the current host at a system assigned port.
 * Before returning, [self _connectAction_:]
 * is called to perform connection initialization actions.
 */

- (void)connectToHost:(NSString *)remoteHost
{
    _socket_ = [_socketFactory_ createSocketToHost:remoteHost toPort:_defaultPort_];
    [self _connectAction_];
}

/**
 * Disconnects the socket connection.
 * You should call this method after you've finished using the class
 * instance and also before you call
 * [self connect:]
 * again.  _isConnected_ is set to false, _socket_ is set to null,
 * _input_ is set to null, and _output_ is set to null.
 */
- (void)disconnect
{
    [_socket_ close];
    [_output_ close];
    [_input_ close];
    _socket_ = nil;
    _input_ = nil;
    _output_ = nil;
    _isConnected_ = NO;    
}

/**
 * Set the timeout in milliseconds of a currently open connection.
 * Only call this method after a connection has been opened
 * by [self connect:].
 */
- (void)setSoTimeout:(NSTimeInterval)timeout
{
    _socket_.soTimeout = timeout;
}

/**
 * Returns the timeout in milliseconds of the currently opened socket.
 */
- (NSTimeInterval)soTimeout
{
    return _socket_.soTimeout;
}

/**
 * Enables or disables the Nagle's algorithm (TCP_NODELAY) on the
 * currently opened socket.
 */
- (void)setTcpNoDelay:(BOOL)on
{
    _socket_.tcpNoDelay = on;
}

/**
 * Returns true if Nagle's algorithm is enabled on the currently opened
 * socket.
 */
- (BOOL)tcpNoDelay
{
    return _socket_.tcpNoDelay;
}

/**
 * Sets the SO_LINGER timeout on the currently opened socket.
 */
- (void)setSoLinger:(BOOL)linger length:(NSTimeInterval)length
{
    [_socket_ setSoLinger:linger length:length];
}

/**
 * Returns the current SO_LINGER timeout of the currently opened socket.
 */
- (NSTimeInterval)soLinger
{
    return [_socket_ soLinger];
}

/**
 * Returns the port number of the open socket on the local host used
 * for the connection.
 */
- (int)localPort
{
    return _socket_.localPort;
}

/**
 * Returns the local address to which the client's socket is bound.
 */
- (NSHost *)localHost
{
    return _socket_.localHost;
}

/**
 * Returns the port number of the remote host to which the client is
 * connected.
 */
- (int)remotePort
{
    return _socket_.port;
}

/**
 * Returns the remote address to which the client is connected.
 */
- (NSHost *)remoteHost
{
    return _socket_.host;
}

/**
 * Verifies that the remote end of the given socket is connected to the
 * the same host that the SocketClient is currently connected to.  This
 * is useful for doing a quick security check when a client needs to
 * accept a connection from a server, such as an FTP data connection or
 * a BSD R command standard error stream.
 */
- (BOOL)verifyRemote:(WXSocket *)socket
{
    NSHost *host1, *host2;
    
    host1 = _socket_.host;
    host2 = [self remoteHost];
    return [host1 isEqualToHost:host2];    
}

/**
 * Sets the SocketFactory used by the SocketClient to open socket
 * connections.  If the factory value is null, then a default
 * factory is used (only do this to reset the factory after having
 * previously altered it).
 */
- (void)setSocketFactory:(id<WXSocketFactory>)factory
{
    if(factory == nil) {
        _socketFactory_ = __DEFAULT_SOCKET_FACTORY;
    } else {
        _socketFactory_ = factory;
    }
}

@end
