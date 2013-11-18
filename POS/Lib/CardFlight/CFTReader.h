//
//  Reader.h
//  CardFlightLibrary
//
//  Created by Elie Toubiana on 11/11/13.
//  Copyright (c) 2013 CardFlight Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class CFTCard;

@protocol readerDelegate <NSObject>

@required
- (void)readerResponse:(CFTCard *)card withError:(NSError *)error;

@end

@interface CFTReader : NSObject

@property (nonatomic, weak) id<readerDelegate> delegate;

- (id)initAndConnect;
- (void)beginSwipeWithMessage:(NSString *)message;
- (void)connect;
- (void)disconnect;

@end
