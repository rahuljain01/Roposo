//
//  userList.m
//  Roposo
//
//  Created by Rahul Jain on 3/30/16.
//  Copyright © 2016 Rahul Jain. All rights reserved.
//

#import "UserList.h"

@implementation UserList

-(instancetype)init{
    self = [super init];
    
    if (self) {
        self.users = [[NSMutableArray alloc] init];
    }
    
    return self;
}

@end
