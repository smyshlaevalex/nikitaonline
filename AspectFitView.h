//
//  AspectFitView.h
//  nikitaonline iOS
//
//  Created by Alexander Smyshlaev on 02/07/2019.
//  Copyright © 2019 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AspectFitView : CCNode

@property(nonatomic) CCNode *contentNode;
@property(nonatomic) CGFloat zoomScale;

@property(nonatomic) CGSize originalSize;

+ (instancetype)aspectFitViewWithContentNode:(CCNode *)node originalSize:(CGSize)originalSize;

@end

NS_ASSUME_NONNULL_END
