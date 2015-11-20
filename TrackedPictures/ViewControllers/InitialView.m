//
//  InitialView.m
//  
//
//  Created by William Hass on 11/20/15.
//
//

#import "InitialView.h"
#import "AppTheme.h"

CGFloat const InitialViewFastAnimationDuration = 0.15;

@interface InitialView()

@property (weak, nonatomic) IBOutlet UIButton *startStopButton;
@property (weak, nonatomic) IBOutlet UILabel *emptyStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *instructionsLabel;
@property (weak, nonatomic) IBOutlet UIView *emptyStateContainer;
@property (strong, nonatomic) IBOutlet UIView *tableHeaderView;

@end

@implementation InitialView

#pragma mark - Initializers

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupView];
}


#pragma mark - Private

- (void)setupView {

    [self updateLocationButton:NO];
    [self setInstructionsVisible:YES];
    [self setEmptyStateVisible:YES];
    
    // We don't want to present extra empty rows
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.tableHeaderView.backgroundColor = [AppTheme tableHeaderColor];
    self.tableView.allowsSelection = NO;
    
    self.emptyStateLabel.text = NSLocalizedString(@"EMPTY_STATE_MESSAGE", nil);
    self.emptyStateLabel.textColor = [AppTheme lightGrayText];
    self.instructionsLabel.text = NSLocalizedString(@"INSTRUCTIONS_MESSAGE",nil);
}



#pragma mark - Public

- (void)setEmptyStateVisible:(BOOL)visible {
    void (^animationBlock)(void) = ^ {
        if (visible) {
            self.tableView.alpha = 0;
            self.emptyStateContainer.alpha = 1;
        } else {
            self.tableView.alpha = 1;
            self.emptyStateContainer.alpha = 0;
        }
    };
    [UIView animateWithDuration:InitialViewFastAnimationDuration animations:animationBlock];
}

- (void)updateLocationButton:(BOOL)tracking {
    
    void (^changesBlock)(void) = ^{
        if (tracking) {
            self.startStopButton.backgroundColor = [AppTheme activeColor];
            [self.startStopButton setTitleColor:[AppTheme textBaseColor] forState:UIControlStateNormal];
            [self.startStopButton setTitle:NSLocalizedString(@"STOP_WORD", nil) forState:UIControlStateNormal];
        } else {
            self.startStopButton.backgroundColor = [AppTheme baseColor];
            [self.startStopButton setTitleColor:[AppTheme textBaseColor] forState:UIControlStateNormal];
            [self.startStopButton setTitle:NSLocalizedString(@"START_WORD", nil) forState:UIControlStateNormal];
        }
    };
    [UIView animateWithDuration:InitialViewFastAnimationDuration animations:changesBlock];
}

- (void)setInstructionsVisible:(BOOL)visible {
    if (visible) {
        self.tableView.tableHeaderView = self.tableHeaderView;
    } else {
        self.tableView.tableHeaderView = nil;
    }
}

@end
