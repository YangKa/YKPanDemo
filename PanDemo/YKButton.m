//
//  YKButton.m
//  PanDemo
//
//  Created by qianzhan on 15/11/25.
//  Copyright © 2015年 qianzhan. All rights reserved.
//

#import "YKButton.h"

@implementation YKButton

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent *)event{
    [self touchesBegan:touches withEvent:event];
    self.transform = CGAffineTransformScale(self.transform, 1.3, 1.3);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self touchesEnded:touches withEvent:event];
    self.transform = CGAffineTransformScale(self.transform, 1.0/1.3, 1.0/1.3);
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [self touchesCancelled:touches withEvent:event];
    self.transform = CGAffineTransformScale(self.transform, 1.0/1.3, 1.0/1.3);
}

@end
