//
//  DetailViewController.m
//  Roposo
//
//  Created by Rahul Jain on 3/31/16.
//  Copyright © 2016 Rahul Jain. All rights reserved.
//

#import "DetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *storyImageView;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIButton *followButton;
@property (weak, nonatomic) IBOutlet UILabel *storyTitle;
@property (weak, nonatomic) IBOutlet UILabel *storyDiscription;
@property (weak, nonatomic) IBOutlet UILabel *likes;
@property (weak, nonatomic) IBOutlet UILabel *comments;
@property (weak, nonatomic) IBOutlet UILabel *verb;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureView];
}

-(void)configureView{
    
   // SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    [self.storyImageView sd_setImageWithURL:[NSURL URLWithString:self.story.imageUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            CGFloat aspectRatio = self.storyImageView.frame.size.width/image.size.width;
        
            [self.storyImageView setFrame:CGRectMake(self.storyImageView.frame.origin.x, self.storyImageView.frame.origin.y, self.storyImageView.frame.size.width, image.size.height * aspectRatio)];
            
        });
    }];
    
    [self.userImage sd_setImageWithURL:[NSURL URLWithString:self.story.user.imageurl]];
    
    
    
    self.userName.text = self.story.user.userName;
    [self.userName setTextColor:[UIColor whiteColor]];
    self.storyTitle.text = self.story.title;
    self.storyDiscription.text = self.story.storyDescription;
    self.likes.text = [NSString stringWithFormat:@"%@ Likes",self.story.likes];
    self.comments.text = [NSString stringWithFormat:@"%@ Comments",self.story.comments];
    self.verb.text = self.story.verb;
    if(self.story.user.isFollowing){
        [self.followButton setTitle:@"following" forState:UIControlStateNormal]; //check why everybody is following
    }else{
        [self.followButton setTitle:@"follow" forState:UIControlStateNormal];
    }
    
}
- (IBAction)followButtonPressed:(UIButton *)sender {
    
    self.story.user.isFollowing = !self.story.user.isFollowing;
    
    
    if (self.story.user.isFollowing) {
        [sender setTitle:@"following" forState:UIControlStateNormal];
    }else{
        [sender setTitle:@"follow" forState:UIControlStateNormal];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshTableView" object:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
