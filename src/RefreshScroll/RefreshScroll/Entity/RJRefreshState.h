//
//  RJRefreshState.h
//  RefreshScrollDemo
//
//  Created by Youyi Zhang on 13-09-30.
//  Copyright (c) 2013 Youyi Zhang. All rights reserved.
//

#ifndef RJREFRESH_STATE_H
#define RJREFRESH_STATE_H

/**
 * Refresh state
 */
typedef enum _RJRefreshState {
	RJRefreshPulling = 0,       //Pulling state
	RJRefreshNormal,            //Normal state
	RJRefreshLoading,           //Loading state
} RJRefreshState;

#endif
