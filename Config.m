//
//  Config.m
//  nikitaonline
//
//  Created by Alexander Smyshlaev on 02/07/2019.
//  Copyright © 2019 Apportable. All rights reserved.
//

#import "Config.h"

@implementation Config

- (instancetype)initWithBackgroundImageName:(NSString *)backgroundImageName
                                      items:(NSArray<Item *> *)items {
    self = [super init];
    if (self) {
        _backgroundImageName = backgroundImageName;
        _items = items;
    }
    return self;
}

@end
