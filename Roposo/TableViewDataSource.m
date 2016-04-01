//
//  TableViewDataSource.m
//  Roposo
//
//  Created by Rahul Jain on 4/1/16.
//  Copyright © 2016 Rahul Jain. All rights reserved.
//

#import "TableViewDataSource.h"

@interface TableViewDataSource ()

@property (nonatomic,strong) NSArray* items;
@property (nonatomic,strong) NSString* cellIdentifier;

@end

@implementation TableViewDataSource{
    
    void (^configureCellBlock)(id cell, id item, NSInteger row);
}

-(instancetype) initWithItems:(NSArray *)items
                   cellIdentifier:(NSString *)cellIdentifier
           configureCellBlock:(void (^) (id cell, id item, NSInteger row) )configureCell{
    
    self = [super init];
    
    if (self) {
        
        self.items = [[NSArray alloc] initWithArray:items];
        self.cellIdentifier = cellIdentifier;
        configureCellBlock = configureCell;
    }
    return self;
}



- (id)itemAtIndexPath:(NSIndexPath*)indexPath {
    return self.items[(NSUInteger)indexPath.row];
}

- (NSInteger)tableView:(UITableView*)tableView
 numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    
    id cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier
                                              forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    configureCellBlock(cell,item,indexPath.row);
    return cell;
}

@end
