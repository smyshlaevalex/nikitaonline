//
//  ZoomingView.h
//  nikitaonline
//
//  Created by Alexander Smyshlaev on 02/07/2019.
//  Copyright © 2019 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AspectFitView;

NS_ASSUME_NONNULL_BEGIN

@interface ZoomingView : CCScrollView

@property(nonatomic) CGFloat minimumZoomScale;
@property(nonatomic) CGFloat maximumZoomScale;

@property(nonatomic) BOOL centerContents;
@property(nonatomic) CGSize containerSizeForCentering;

+ (instancetype)zoomingViewWithAspectFitView:(AspectFitView *)aspectFitView;

@end

NS_ASSUME_NONNULL_END
