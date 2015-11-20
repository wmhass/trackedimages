//
//  InitialViewController.m
//  
//
//  Created by William Hass on 11/20/15.
//
//

#import "InitialViewController.h"
#import "InitialView.h"
#import "InitialViewControllerPresenter.h"

@interface InitialViewController () <UITableViewDataSource, UITableViewDelegate, InitialViewControllerPresenterDelegate>

@property (nonatomic,retain) InitialView *view;
@property (strong, nonatomic) InitialViewControllerPresenter *presenter;
@property (strong, nonatomic) NSMutableArray *pictures;

@end

@implementation InitialViewController
@dynamic view;

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.presenter = [[InitialViewControllerPresenter alloc] init];
    self.pictures = [[NSMutableArray alloc] init];
}

#pragma mark - IBActions

- (IBAction)btnToggleLocationTouched:(id)sender {
    [self.presenter toggleTrackLocation];
    [self.view setEmptyStateVisible:!(self.presenter.isTracking)];
    [self.view updateLocationButton:self.presenter.isTracking];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
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


#pragma mark - InitialViewControllerPresenterDelegate

@interface InitialViewController(InitialViewControllerPresenterDelegate)
@end

@implementation InitialViewController(InitialViewControllerPresenterDelegate)

- (void)initialViewControllerPresenter:(InitialViewControllerPresenter *)presenter loadedPictures:(NSArray *)pictures {
    
}

- (void)initialViewControllerPresenter:(InitialViewControllerPresenter *)presenter errorOccurredLoadingPictures:(NSString *)errorMessage {
    
}

@end
