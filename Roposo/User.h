//
//  User.h
//  Roposo
//
//  Created by Rahul Jain on 3/30/16.
//  Copyright © 2016 Rahul Jain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSNumber *followers;
@property (nonatomic,strong) NSNumber *following;
@property (nonatomic,strong) NSString *imageurl;
@property (nonatomic,strong) NSString *about;
@property (nonatomic,strong) NSString *url;
@property (nonatomic) BOOL isFollowing;

@end
