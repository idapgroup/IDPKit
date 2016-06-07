//
//  IDPCompilerMacros.h
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 3/7/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#define IDPClangDiagnosticPush _Pragma("clang diagnostic push")
#define IDPClangDiagnosticPop _Pragma("clang diagnostic pop")

#define IDPClangDiagnosticPushExpression(key) \
    IDPClangDiagnosticPush; \
    _Pragma(key);

#define IDPClangDiagnosticPopExpression IDPClangDiagnosticPop

#define IDPClangIgnorePerformSelectorWarning(code) \
    do { \
        IDPClangDiagnosticPushExpression("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
        code \
        IDPClangDiagnosticPopExpression \
    } while(0)
