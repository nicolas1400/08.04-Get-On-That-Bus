//
//  ViewController.m
//  Get On That Bus
//
//  Created by Nicolas Semenas on 05/08/14.
//  Copyright (c) 2014 Nicolas Semenas. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "StopAnnotation.h"
#import "DetailViewController.h"

@interface ViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *myMapView;
@property (nonatomic, strong) NSArray * stops;
@property (nonatomic) StopAnnotation *pointAnnotation; //PIN ON THE MAP

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self zoom];
    
    NSURL *url = [NSURL URLWithString:@"https://s3.amazonaws.com/mobile-makers-lib/bus.json"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSDictionary * result = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.stops = [result objectForKey:@"row"];
       
        for (NSDictionary * stop in self.stops){
            
            CLLocationCoordinate2D coordinate;
            coordinate.latitude = [[stop objectForKey:@"latitude"] doubleValue];
            coordinate.longitude = [[stop objectForKey:@"longitude"] doubleValue];
        
            //BUG FIX
              if (coordinate.longitude > 0){
                  coordinate.longitude = coordinate.longitude * -1;
              }

            self.pointAnnotation = [[StopAnnotation alloc] init];
            self.pointAnnotation.coordinate = coordinate;
            self.pointAnnotation.title = [stop objectForKey:@"cta_stop_name"];
            self.pointAnnotation.subtitle = [NSString stringWithFormat:@"No. of routes: %f",[[stop objectForKey:@"routes"]doubleValue]];
            
            self.pointAnnotation.address = [stop objectForKey:@"_address"];
            self.pointAnnotation.busRoutes = [stop objectForKey:@"routes"];
            self.pointAnnotation.transfers = [stop objectForKey:@"inter_modal"];


         
            [self.myMapView addAnnotation:self.pointAnnotation];
            
        }
        
    }
     ];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(MKPinAnnotationView *)sender{

    if ([segue.identifier isEqualToString:@"onDetails"])
    {
        DetailViewController *destinationViewController = segue.destinationViewController;
        
        destinationViewController.stop = sender.annotation;

    }
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    [self performSegueWithIdentifier:@"onDetails" sender:view];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"loc"];
    annotationView.canShowCallout = YES;
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    return annotationView;
}


- (void)zoom{
	CLGeocoder *geocoder = [[CLGeocoder alloc] init];
	[geocoder geocodeAddressString:@"Chicago" completionHandler:^(NSArray *placemarks, NSError *error) {
		CLPlacemark *placemark = placemarks[0];
		CLCircularRegion *region = (CLCircularRegion *)placemark.region;
        
		[self.myMapView setRegion:MKCoordinateRegionMakeWithDistance(placemark.location.coordinate, region.radius, region.radius) animated:YES];
    }];
}



@end
