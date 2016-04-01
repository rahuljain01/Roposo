//
//  TableViewDataSource.h
//  Roposo
//
//  Created by Rahul Jain on 4/1/16.
//  Copyright © 2016 Rahul Jain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TableViewDataSource : NSObject <UITableViewDataSource>


-(instancetype) initWithItems:(NSArray *)items
               cellIdentifier:(NSString *)cellIdentifier
           configureCellBlock:(void (^) (id cell, id item, NSInteger row) )configureCell;

@end
