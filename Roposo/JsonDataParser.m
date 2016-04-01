//
//  JsonDataParser.m
//  Roposo
//
//  Created by Rahul Jain on 3/30/16.
//  Copyright © 2016 Rahul Jain. All rights reserved.
//

#import "JsonDataParser.h"
#import "UserList.h"
#import "User.h"
#import "Story.h"
#import "StoryList.h"

@implementation JsonDataParser

-(NSArray *)parseJaonDataWithFileName:(NSString *)fileName{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    UserList *userList = [[UserList alloc] init];
    StoryList *storyList = [[StoryList alloc] init];
    
    
    for (NSDictionary *storyOrUser in json) {
        if ([storyOrUser objectForKey:@"about"] != nil) {
            User *user = [[User alloc] init];
            user.about = [storyOrUser objectForKey:@"about"];
            user.userName = [storyOrUser objectForKey:@"username"];
            user.followers = [storyOrUser objectForKey:@"followers"];
            user.following = [storyOrUser objectForKey:@"following"];
            user.isFollowing = [[storyOrUser objectForKey:@"is_following"] boolValue];
            user.imageurl = [storyOrUser objectForKey:@"image"];
            user.url = [storyOrUser objectForKey:@"url"];
            
            [userList.users addObject:user];
        }
    }
    
    for (NSDictionary *storyOrUser in json) {
        if ([storyOrUser objectForKey:@"about"] == nil) {
            Story *story = [[Story alloc] init];
            
            
            story.comments = [storyOrUser objectForKey:@"comment_count"];
            story.likes = [storyOrUser objectForKey:@"likes_count"];
            story.db = [storyOrUser objectForKey:@"db"];
            story.storyDescription = [storyOrUser objectForKey:@"description"];
            story.verb = [storyOrUser objectForKey:@"verb"];
            story.imageUrl = [storyOrUser objectForKey:@"si"];
            story.title = [storyOrUser objectForKey:@"title"];
            story.likeFlag = [[storyOrUser objectForKey:@"like_flag"] boolValue];
            for (User *user in userList.users) {
                if([user.url containsString:story.db]){
                    story.user = user;
                }
            }
            [storyList.stories addObject:story];
        }
    }
    NSArray *array = [[NSArray alloc] initWithObjects:userList,storyList, nil];
    
    return array;
}

@end
