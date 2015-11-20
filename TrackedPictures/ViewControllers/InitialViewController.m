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

#pragma mark - IBActions

- (IBAction)btnToggleLocationTouched:(id)sender {
    [self.presenter toggleTrackLocation];
    [self.view setEmptyStateVisible:!(self.presenter.isTracking)];
    [self.view updateLocationButton:self.presenter.isTracking];
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
}

- (void)initialViewControllerPresenter:(InitialViewControllerPresenter *)presenter errorOccurredLoadingPictures:(NSString *)errorMessage {

    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK_WORD", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    UIAlertController *alert = [[UIAlertController alloc] init];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end


#pragma mark - UITableViewDelegate

@interface InitialViewController(UITableViewDelegate) <UITableViewDelegate>
@end

@implementation InitialViewController(UITableViewDelegate)

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.sizingCell setNeedsLayout];
    [self.sizingCell layoutIfNeeded];
    
    return CGRectGetHeight(self.sizingCell.contentView.frame);
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
