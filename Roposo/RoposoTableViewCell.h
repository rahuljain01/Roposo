//
//  RoposoTableViewCell.h
//  Roposo
//
//  Created by Rahul Jain on 3/30/16.
//  Copyright © 2016 Rahul Jain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoposoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UIButton *followButton;
@property (weak, nonatomic) IBOutlet UILabel *storyDescription;
@property (weak, nonatomic) IBOutlet UIImageView *storyImageView;
@property (weak, nonatomic) IBOutlet UILabel *likes;

@property (weak, nonatomic) IBOutlet UILabel *comments;
@property (weak, nonatomic) IBOutlet UILabel *verb;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end
