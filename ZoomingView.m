//
//  ZoomingView.m
//  nikitaonline
//
//  Created by Alexander Smyshlaev on 02/07/2019.
//  Copyright © 2019 Apportable. All rights reserved.
//

#import "ZoomingView.h"

#import "AspectFitView.h"

@interface ZoomingView ()

@property(nonatomic) CGFloat previousZoomScale;

#if __CC_PLATFORM_IOS
@property(nonatomic) UIPinchGestureRecognizer *pinchRecognizer;
#endif

@end

@implementation ZoomingView

- (instancetype)initWithContentNode:(CCNode *)contentNode {
    self = [super initWithContentNode:contentNode];
    if (self) {
        _minimumZoomScale = 1;
        _maximumZoomScale = 1;
        
#if __CC_PLATFORM_IOS
        _pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(didPinch:)];
#endif
    }
    return self;
}

- (void)onEnterTransitionDidFinish {
#if __CC_PLATFORM_IOS
    UIView* view = [CCDirector sharedDirector].view;
    
    NSMutableArray* recognizers = [view.gestureRecognizers mutableCopy];
    if (!recognizers) recognizers = [NSMutableArray arrayWithCapacity:1];
    [recognizers insertObject:self.pinchRecognizer atIndex:0];
    
    view.gestureRecognizers = recognizers;
    [super onEnterTransitionDidFinish];
#endif
}

- (void)onExitTransitionDidStart {
#if __CC_PLATFORM_IOS
    UIView* view = [CCDirector sharedDirector].view;
    
    NSMutableArray* recognizers = [view.gestureRecognizers mutableCopy];
    [recognizers removeObject:self.pinchRecognizer];
    
    view.gestureRecognizers = recognizers;
    
    [super onExitTransitionDidStart];
#endif
}

- (float)minScrollX {
    float offset = self.centerContents ?
    fabs(self.containerSizeForCentering.width / 2 - self.aspectFitView.contentSize.width / 2) : 0;
    
    return [super minScrollX] - offset;
}

- (float)minScrollY {
    float offset = self.centerContents ?
    fabs(self.containerSizeForCentering.height / 2 - self.aspectFitView.contentSize.height / 2) : 0;
    
    return [super minScrollY] - offset;
}

- (float)maxScrollX {
    float offset = self.centerContents ?
    fabs(self.containerSizeForCentering.width / 2 - self.aspectFitView.contentSize.width / 2) : 0;

    return [super maxScrollX] - offset;
}

- (float)maxScrollY {
    float offset = self.centerContents ?
    fabs(self.containerSizeForCentering.height / 2 - self.aspectFitView.contentSize.height / 2) : 0;
    
    return [super maxScrollY] + offset;
}

#if __CC_PLATFORM_IOS
- (void)didPinch:(UIPinchGestureRecognizer *)gestureRecognizer {
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            self.previousZoomScale = self.aspectFitView.zoomScale;
        default: {
            CGFloat newScale = self.previousZoomScale * gestureRecognizer.scale;
            newScale = MIN(self.maximumZoomScale, MAX(self.minimumZoomScale, newScale));
            
            self.aspectFitView.zoomScale = newScale;
        }
    }
}
#endif

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return NO;
}

#pragma mark - Private

+ (instancetype)zoomingViewWithAspectFitView:(AspectFitView *)aspectFitView {
    return [[self alloc] initWithContentNode:aspectFitView];
}

- (AspectFitView *)aspectFitView {
    return (AspectFitView *)self.contentNode;
}

@end
