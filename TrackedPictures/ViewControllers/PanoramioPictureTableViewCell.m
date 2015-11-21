//
//  PanoramioPictureTableViewCell.m
//  
//
//  Created by William Hass on 11/20/15.
//
//

#import "PanoramioPictureTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

NSString * const PanoramioPictureTableViewCellReuseIdentifier = @"PanoramioPictureTableViewCell";
NSString * const PanoramioPictureTableViewCellNibName = @"PanoramioPictureTableViewCell";
CGFloat const PanoramioPictureTableViewCellBottomPadding = 15;

@interface PanoramioPictureTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;
@property (weak, nonatomic) IBOutlet UILabel *pictureTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *ownerNameLabel;

@end

@implementation PanoramioPictureTableViewCell

#pragma mark - Lifecycle

- (void)prepareForReuse {
    [super prepareForReuse];
    [self resetCell];
}

- (void)awakeFromNib {
    [self resetCell];
}

#pragma mark - Private

- (void)resetCell {
    self.pictureImageView.image = nil;
    self.pictureTitleLabel.text = nil;
    self.dateLabel.text = nil;
    self.ownerNameLabel.text = nil;
}


#pragma mark - Public

- (void)configureWithImageURL:(NSURL *)imageURL titile:(NSString *)title ownerName:(NSString *)ownerName date:(NSString *)date {
    
    if (imageURL) {
        [self.pictureImageView sd_setImageWithURL:imageURL];
    }
    
    self.pictureTitleLabel.text = title;
    self.dateLabel.text = date;
    self.ownerNameLabel.text = ownerName;
    
}

- (CGFloat)contentHeight {
    
    return CGRectGetMaxY(self.ownerNameLabel.frame)+PanoramioPictureTableViewCellBottomPadding;
}

@end
