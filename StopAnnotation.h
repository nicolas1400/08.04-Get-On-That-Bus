//
//  StopAnnotation.h
//  GetOnThatBus
//
//  Created by Nicolas Semenas on 06/08/14.
//  Copyright (c) 2014 Nicolas Semenas. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface StopAnnotation : MKPointAnnotation

@property (nonatomic, strong) NSString * address;
@property (nonatomic, strong) NSString * busRoutes;
@property (nonatomic, strong) NSString * transfers;


@end
