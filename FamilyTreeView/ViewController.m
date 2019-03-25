//
//  ViewController.m
//  FamilyTreeView
//
//  Created by Ruslan on 3/25/19.
//  Copyright © 2019 Ruslan. All rights reserved.
//

#import "ViewController.h"
#import "FamilyTree/FamilyTreeView.h"

@interface ViewController () <FamilyTreeViewDelegate>
@property (weak, nonatomic) IBOutlet FamilyTreeView * familyTreeView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Creating connections for view
    NSMutableArray<NSArray<ConnectionModel *> *> * connections = [NSMutableArray new];
    for (int j = 0; j < 5; j++) {
        NSMutableArray<ConnectionModel *> * connectionsForCicrcle = [NSMutableArray new];
        for (int i = 0; i < 6; i++) {
            ConnectionModel * model = [ConnectionModel new];
            model.photoUrl = @"https://upload.wikimedia.org/wikipedia/commons/thumb/e/ea/Breathe-face-smile.svg/128px-Breathe-face-smile.svg.png";
            model.connectionLevel = i;
            model.connectionId = [NSString stringWithFormat:@"%d", i];
            model.title = [NSString stringWithFormat:@"title %d", i];
            [connectionsForCicrcle addObject:model];
        }
        [connections addObject:connectionsForCicrcle];
    }
    
    self.familyTreeView.mainUserPhotoURL = @"https://upload.wikimedia.org/wikipedia/commons/thumb/e/ea/Breathe-face-smile.svg/128px-Breathe-face-smile.svg.png";
    self.familyTreeView.allConnections = connections;
    self.familyTreeView.delegate = self;
    [self.familyTreeView reloadData];
    
}

- (void) imageWasTappedWith:(ImageData *)data
{
    NSLog(@"tap");
}

@end
