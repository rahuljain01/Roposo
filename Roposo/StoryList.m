//
//  StoryList.m
//  Roposo
//
//  Created by Rahul Jain on 3/30/16.
//  Copyright © 2016 Rahul Jain. All rights reserved.
//

#import "StoryList.h"

@implementation StoryList

-(instancetype)init{
    self = [super init];
    
    if (self) {
        self.stories = [[NSMutableArray alloc] init];
    }
    
    return self;
}

@end
