//
//  AspectFitView.m
//  nikitaonline iOS
//
//  Created by Alexander Smyshlaev on 02/07/2019.
//  Copyright © 2019 Apportable. All rights reserved.
//

#import "AspectFitView.h"

@implementation AspectFitView

+ (instancetype)aspectFitViewWithContentNode:(CCNode *)node originalSize:(CGSize)originalSize {
    AspectFitView *view = [AspectFitView node];
    view.contentNode = node;
    view.originalSize = originalSize;
    view.contentSize = originalSize;
    view.zoomScale = 1;
    
    return view;
}

- (void)setZoomScale:(CGFloat)zoomScale {
    _zoomScale = zoomScale;
    
    self.contentSize = CGSizeMake(self.originalSize.width * zoomScale,
                                  self.originalSize.height * zoomScale);
    self.contentNode.scale = zoomScale;
}

- (void)setContentNode:(CCNode *)contentNode {
    [self removeChild:_contentNode];
    
    _contentNode = contentNode;
    
    [self addChild:contentNode];
}

@end
