//
//  AISCardCell.h
//  AirAsia
//
//  Created by ATS on 3/27/18.
//  Copyright © 2018 AirAsia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AISCardCell : UICollectionViewCell
@property(nonatomic,weak)IBOutlet UIImageView *cardImage;
@property(nonatomic,weak)IBOutlet UIImageView *check;
@property(nonatomic,weak)IBOutlet UILabel *price;
@end
