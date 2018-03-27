//
//  AISUserView.m
//  AirAsia
//
//  Created by ATS on 3/23/18.
//  Copyright © 2018 AirAsia. All rights reserved.
//

#import "AISUserView.h"
#import "AISUIUtility.h"

@interface AISUserView()
@property(nonatomic,weak) IBOutlet UIImageView *avatar;
@property(nonatomic,weak) IBOutlet UILabel *welcomeLabel;
@property(nonatomic,weak) IBOutlet UILabel *name;

@property(nonatomic,strong)NSString *username;
@property(nonatomic,strong)NSString *avatarPath;

@end

@implementation AISUserView

- (instancetype)initWithName:(NSString *)name andAvatarPath:(NSString *)path {
    self = [super init];
    if (self) {
        self.username = name;
        self.avatarPath = path;
        [self setUpUI];
    }
    return self;
}


- (void)updateViewWithName:(NSString *)name andAvatarPath:(NSString *)path {
    self.username = name;
    self.avatarPath = path;
    [self setUpUI];
}

-(void)setUpUI {
    //[AISUIUtility addThemeToView:self];
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor redColor].CGColor;
    
    self.layer.masksToBounds = NO;
    self.layer.shadowOffset = CGSizeMake(-2, 2);
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = 0.5;
    
//    self.layer.cornerRadius = 10;
//    self.layer.masksToBounds = YES;

    
    self.welcomeLabel.textColor = [UIColor redColor];
    self.welcomeLabel.text = @"Welcome !!!!";
    self.name.textColor = [UIColor redColor];
    self.name.text = self.username;
    
    self.avatar.layer.cornerRadius = self.avatar.bounds.size.height/2;
    self.avatar.layer.masksToBounds = YES;
    self.avatar.backgroundColor = [UIColor redColor];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
