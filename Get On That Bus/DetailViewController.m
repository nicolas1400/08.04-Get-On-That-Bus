//
//  DetailViewController.m
//  GetOnThatBus
//
//  Created by Nicolas Semenas on 06/08/14.
//  Copyright (c) 2014 Nicolas Semenas. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *busRoutes;
@property (weak, nonatomic) IBOutlet UILabel *transfers;

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.stop.title;
    self.addressLabel.text = self.stop.address;
    self.busRoutes.text = self.stop.busRoutes;
    self.transfers.text = self.stop.transfers;


    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
