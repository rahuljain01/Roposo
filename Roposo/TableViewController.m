//
//  ViewController.m
//  Roposo
//
//  Created by Rahul Jain on 3/29/16.
//  Copyright © 2016 Rahul Jain. All rights reserved.
//

#import "TableViewController.h"
#import "JsonDataParser.h"
#import "UserList.h"
#import "StoryList.h"
#import "User.h"
#import "Story.h"
#import "RoposoTableViewCell.h"
#import "DetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <ImageIO/ImageIO.h>
#import "TableViewDataSource.h"

@interface TableViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) StoryList* storyList;
@property (nonatomic,strong) UserList* userList;
@property (nonatomic,strong) NSMutableArray* imageArray;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JsonDataParser *jsonDataParse = [[JsonDataParser alloc] init];
    
    NSArray *userAndStoriesArray = [jsonDataParse parseJaonDataWithFileName:@"Data"];
    
    self.storyList = [userAndStoriesArray objectAtIndex:1];
    self.userList = [userAndStoriesArray objectAtIndex:0];
    
    [self makeNavigationBarTransparent];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50.0;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

-(void)makeNavigationBarTransparent{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    self.tableView.contentInset = UIEdgeInsetsMake(-44,0,0,0);
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.storyList.stories.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     RoposoTableViewCell *cell = (RoposoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Roposo cell"];
    
    if (cell == nil) {
        
        cell = [[RoposoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Roposo cell"];
    }
    
    Story *story = [self.storyList.stories objectAtIndex:indexPath.row];
    
    // round the image
    [cell.userImage sd_setImageWithURL:[NSURL URLWithString:story.user.imageurl]
                      placeholderImage:[UIImage imageNamed:@"Placeholder"]];
    
    cell.username.text = story.user.userName;
    cell.storyDescription.text = story.storyDescription;
    [cell.storyDescription sizeToFit];
    
    cell.likes.text = [NSString stringWithFormat:@"%@ Likes",[story.likes stringValue]];
    cell.comments.text = [NSString stringWithFormat:@"%@ Comments",[story.comments stringValue]];
    cell.verb.text = story.verb;
    cell.title.text = story.title;
    [cell.title sizeToFit];
    
    cell.followButton.tag = indexPath.row;
    if (story.user.isFollowing) {
        [cell.followButton setTitle:@"following" forState:UIControlStateNormal];
    }else{
        [cell.followButton setTitle:@"follow" forState:UIControlStateNormal];
    }
    
    [cell.followButton.titleLabel sizeToFit];
    
   __weak RoposoTableViewCell* weakCell = cell;
    // change placeholder and height of image according to aspect ratio
    [cell.storyImageView sd_setImageWithURL:[NSURL URLWithString:story.imageUrl]
                      placeholderImage:[UIImage imageNamed:@"storyImagePlaceholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                          if (image) {
                              
                              
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  
                                  CGFloat aspectRatio = weakCell.storyImageView.frame.size.width/image.size.width;
                                  
                                  
                                  [weakCell.storyImageView setFrame:CGRectMake(weakCell.storyImageView.frame.origin.x, weakCell.storyImageView.frame.origin.y, weakCell.storyImageView.frame.size.width, image.size.height * aspectRatio)];

                                  [cell setNeedsUpdateConstraints];
                                  [cell updateConstraintsIfNeeded];
                                  
                              });
                              
                              
                              
                          }
                      }];

    
    
    return cell;
}

- (IBAction)followUser:(UIButton *)sender {
    
    NSInteger row = [sender tag];
    
    Story *story = [self.storyList.stories objectAtIndex:row];
    
    story.user.isFollowing = !story.user.isFollowing;
    
    [self.storyList.stories replaceObjectAtIndex:row withObject:story];
    
    if (story.user.isFollowing) {
        [sender setTitle:@"following" forState:UIControlStateNormal];
    }else{
        [sender setTitle:@"follow" forState:UIControlStateNormal];
    }
    
    [self.tableView reloadData];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    Story *story = [self.storyList.stories objectAtIndex:path.row];
    [(DetailViewController *)segue.destinationViewController setStory:story];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
