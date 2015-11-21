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
#import "PanoramioPictureTableViewCell.h"
#import "PanoramioPictureTableViewCell+PanoramioPicture.h"

@interface InitialViewController () <InitialViewControllerPresenterDelegate>

@property (nonatomic,retain) InitialView *view;
@property (strong, nonatomic) InitialViewControllerPresenter *presenter;
@property (strong, nonatomic) NSArray *pictures;
@property (strong, nonatomic) PanoramioPictureTableViewCell *sizingCell;

@end

@implementation InitialViewController
@dynamic view;

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.presenter = [[InitialViewControllerPresenter alloc] init];
    self.presenter.delegate = self;
    
    UINib *nib = [UINib nibWithNibName:PanoramioPictureTableViewCellNibName bundle:nil];
    [self.view.tableView registerNib:nib forCellReuseIdentifier:PanoramioPictureTableViewCellReuseIdentifier];
    self.sizingCell = [[nib instantiateWithOwner:nil options:nil] lastObject];
}

#pragma mark - Private

- (void)toggleViewMode {
    InitialViewMode mode = InitialViewEmptyNotTrackingMode;
    
    if(self.presenter.isTracking && self.pictures.count == 0) {
        mode = InitialViewEmptyTrackingMode;
    } else if(self.presenter.isTracking && self.pictures.count > 0) {
        mode = InitialViewNotEmptyTracking;
    }
    self.view.mode = mode;
}

#pragma mark - IBActions

- (IBAction)btnToggleLocationTouched:(id)sender {
    [self.presenter toggleTrackLocation];
    [self toggleViewMode];
}

@end


#pragma mark - InitialViewControllerPresenterDelegate

@interface InitialViewController(InitialViewControllerPresenterDelegate)
@end

@implementation InitialViewController(InitialViewControllerPresenterDelegate)

- (void)initialViewControllerPresenter:(InitialViewControllerPresenter *)presenter loadedPictures:(NSArray *)pictures {
    NSMutableArray *allPictures = [[NSMutableArray alloc] initWithCapacity:pictures.count+self.pictures.count];
    [allPictures addObjectsFromArray:pictures];
    [allPictures addObjectsFromArray:self.pictures];
    
    self.pictures = [NSArray arrayWithArray:allPictures];
    [self.view.tableView reloadData];
    [self toggleViewMode];
}

- (void)initialViewControllerPresenter:(InitialViewControllerPresenter *)presenter errorOccurredLoadingPictures:(NSString *)errorMessage {

    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK_WORD", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ERROR_TITLE",nil) message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)initialViewControllerPresenterDidStopTracking:(InitialViewControllerPresenter *)presenter {
    self.pictures = nil;
}

- (void)initialViewControllerPresenterDidStartTracking:(InitialViewControllerPresenter *)presenter {
    [self.view.tableView reloadData];
}

@end


#pragma mark - UITableViewDelegate

@interface InitialViewController(UITableViewDelegate) <UITableViewDelegate>
@end

@implementation InitialViewController(UITableViewDelegate)

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.sizingCell layoutWithPicture:self.pictures[indexPath.row]];
    [self.sizingCell setNeedsLayout];
    [self.sizingCell layoutIfNeeded];
    return [self.sizingCell contentHeight];
}

@end

@interface InitialViewController(UITableViewDataSource) <UITableViewDataSource>
@end

#pragma mark - UITableViewDataSource

@implementation InitialViewController(UITableViewDataSource)


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pictures.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PanoramioPictureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PanoramioPictureTableViewCellReuseIdentifier];

    [cell layoutWithPicture:self.pictures[indexPath.row]];
    
    return cell;
}

@end
