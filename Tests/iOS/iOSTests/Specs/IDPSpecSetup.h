//
//  IDPSpecSetup.h
//  iOS
//
//  Created by Oleksa Korin on 19/1/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

// Set this value to 1 to enable multithreading tests
#define IDPMultithreadedSpecTestEnabled 1

// Set this value to 1 to enable thorough multithreading tests with a lot of iterations
#define IDPLongMultithreadedSpecTest    1

#if IDPMultithreadedSpecTestEnabled == 1
    #if IDPLongMultithreadedSpecTest == 1
        const NSUInteger IDPMultithreadedSpecIterationCount     = 1000 * 10;
        const NSUInteger IDPMultithreadedWaitTime               = 30;
    #else
        const NSUInteger IDPMultithreadedSpecIterationCount     = 10;
        const NSUInteger IDPMultithreadedWaitTime               = 1;
    #endif
#endif