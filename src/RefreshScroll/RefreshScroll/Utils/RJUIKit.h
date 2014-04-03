//
//  RJUIKit.h
//  RefreshScroll
//
//  It defines some macros about iOS UI's API in this file.
//
//  Created by Youyi Zhang on 13-10-12.
//  Copyright (c) 2013 Youyi Zhang. All rights reserved.
//

#ifndef RJUIKIT_H
#define RJUIKIT_H

#define RJColorRGBA(r, g, b, a) ([UIColor colorWithRed:(double)r/255.0 \
    green:(double)g/255.0 blue:(double)b/255.0 alpha:a])
#define RJColorRGB(r, g, b) ([UIColor colorWithRed:(double)r/255.0 \
    green:(double)g/255.0 blue:(double)b/255.0 alpha:1.0])

#define RJANGLE_TO_RADIAN(x) ((M_PI / x) * 180.0f)

#endif
