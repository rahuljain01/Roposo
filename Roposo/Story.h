//
//  story.h
//  Roposo
//
//  Created by Rahul Jain on 3/30/16.
//  Copyright © 2016 Rahul Jain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Story : NSObject

@property (nonatomic,strong) User *user;
@property (nonatomic,strong) NSString *storyDescription;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *verb;
@property (nonatomic,strong) NSString *db;
@property (nonatomic,strong) NSString *imageUrl;
@property (nonatomic,strong) NSNumber *comments;
@property (nonatomic,strong) NSNumber *likes;
@property (nonatomic) BOOL likeFlag;

@end
