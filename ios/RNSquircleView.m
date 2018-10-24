#import "React/RCTViewManager.h"
#import "UIKit/UIKit.h"
#import "Foundation/Foundation.h"
#import "RNSquircleView.h"

@interface RCT_EXTERN_MODULE(SquircleViewManager, RCTViewManager)

RCT_EXPORT_VIEW_PROPERTY(bckColor, NSNumber)

RCT_EXPORT_VIEW_PROPERTY(shdColor, NSNumber)

RCT_EXPORT_VIEW_PROPERTY(shdOpacity, float)

RCT_EXPORT_VIEW_PROPERTY(shdOffsetX, CGFloat)

RCT_EXPORT_VIEW_PROPERTY(shdOffsetY, CGFloat)

RCT_EXPORT_VIEW_PROPERTY(shdRadius, CGFloat)

RCT_EXPORT_VIEW_PROPERTY(brdColor, NSNumber)

RCT_EXPORT_VIEW_PROPERTY(brdWidth, CGFloat)

RCT_EXPORT_VIEW_PROPERTY(brdRadius, CGFloat)

RCT_EXPORT_VIEW_PROPERTY(brdTopLeftRadius, CGFloat)

RCT_EXPORT_VIEW_PROPERTY(brdTopRightRadius, CGFloat)

RCT_EXPORT_VIEW_PROPERTY(brdBottomRightRadius, CGFloat)

RCT_EXPORT_VIEW_PROPERTY(brdBottomLeftRadius, CGFloat)

RCT_EXPORT_VIEW_PROPERTY(interpolatePath, NSNumber)

@end
