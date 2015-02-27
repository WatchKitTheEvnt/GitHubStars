//
//  GHSWatchKitExtensionServiceTest.m
//  GitHubSearch
//
//  Created by César Estébanez Tascón on 17/02/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import <GitHubStarsCoreKit/GitHubStarsCoreKit.h>
#import "GHSWatchKitExtensionService.h"
#import "GHSWatchKitExtensionServiceModuleStub.h"
#import "GHSSharedKeys.h"

@interface GHSWatchKitExtensionServiceTest : XCTestCase

@end

@implementation GHSWatchKitExtensionServiceTest
{
    GHSWatchKitExtensionService *sut;
    GHSWatchKitExtensionServiceModuleStub *watchKitExtensionServiceModule;
}

- (void)setUp
{
    [super setUp];
    watchKitExtensionServiceModule = [[GHSWatchKitExtensionServiceModuleStub alloc] init];
    sut = [[GHSWatchKitExtensionService alloc] initWithWatchKitExtensionServiceModule:watchKitExtensionServiceModule];
}

- (void)testInvalidRequestType_handleWatchKitExtensionRequest_sendReplyWithUnknowReplyTypeError
{
    // given
    NSDictionary *userInfo = @{GHSWatchKitExtensionRequestType : @"Invalid Request Type"};
    
    // when
    __block NSError *error;
    [sut application:nil handleWatchKitExtensionRequest:userInfo reply:^(NSDictionary *replyInfo) {
        error = replyInfo[GHSContainingAppReplyError];
    }];
    
    // then
    XCTAssertTrue([error.domain isEqualToString:GHSContainingAppReplyErrorDomain]);
    XCTAssertTrue(error.code == GHSContainingAppReplyErrorUnknownRequestType);
}

- (void)testRequestFetchUserRespoitories_handleWatchKitExtensionRequest_callsReplyWithFetchedUserRepositories
{
    // given
    NSDictionary *userInfo = @{GHSWatchKitExtensionRequestType : GHSWatchKitExtensionRequestTypeFetchUserRespoitories};
    XCTestExpectation *replyCalled = [self expectationWithDescription:@"reply block should be called"];
    
    // when
    __block GHSUserRepositories *fetchedRepositories;
    [sut application:nil handleWatchKitExtensionRequest:userInfo reply:^(NSDictionary *replyInfo) {
        fetchedRepositories = replyInfo[GHSContainingAppReplyFetchedUserRespoitories];
        [replyCalled fulfill];
    }];
    
    // then
    [self waitForExpectationsWithTimeout:2 handler:nil];
    XCTAssert(fetchedRepositories != nil);
}

@end
