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
    NSTimeInterval socketTimeout;
    
    
}

@property(readonly,atomic) NSInputStream *inputStream;
@property(readonly,atomic) NSOutputStream *outputStream;
@property(assign,atomic) NSTimeInterval socketTimeout;

- (void)close:(NSError **)error;

@end
