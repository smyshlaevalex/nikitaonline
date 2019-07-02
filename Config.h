//
//  Config.h
//  nikitaonline
//
//  Created by Alexander Smyshlaev on 02/07/2019.
//  Copyright © 2019 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Item;

NS_ASSUME_NONNULL_BEGIN

@interface Config : NSObject

@property(nonatomic) NSString *backgroundImageName;
@property(nonatomic) NSArray<Item *> *items;

- (instancetype)initWithBackgroundImageName:(NSString *)backgroundImageName
                                      items:(NSArray<Item *> *)items;

@end

NS_ASSUME_NONNULL_END
