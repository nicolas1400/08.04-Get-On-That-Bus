//
//  DetailViewController.h
//  GetOnThatBus
//
//  Created by Nicolas Semenas on 06/08/14.
//  Copyright (c) 2014 Nicolas Semenas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "StopAnnotation.h"

@interface DetailViewController : UIViewController
@property (nonatomic, strong) StopAnnotation *stop; //PIN ON THE MAP

@end
