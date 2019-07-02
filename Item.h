//
//  Item.h
//  nikitaonline
//
//  Created by Alexander Smyshlaev on 02/07/2019.
//  Copyright © 2019 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ItemPosition;

NS_ASSUME_NONNULL_BEGIN

@interface Item : NSObject

@property(nonatomic) NSString *type;
@property(nonatomic) NSArray<ItemPosition *> *possiblePositions;

- (instancetype)initWithType:(NSString *)type
           possiblePositions:(NSArray<ItemPosition *> *)possiblePositions;

- (ItemPosition *)randomizedPosition;

@end

NS_ASSUME_NONNULL_END
