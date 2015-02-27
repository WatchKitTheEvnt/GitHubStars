//
//  GHSUserRepositoriesTest.m
//  GitHubSearch
//
//  Created by César Estébanez Tascón on 15/02/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "GHSUserRepositories.h"
#import "GHSRepository.h"

@interface GHSUserRepositoriesTest : XCTestCase

@end

@implementation GHSUserRepositoriesTest
{
    GHSUserRepositories *sut;
}

- (void)testNoRepositories_popularRepository_returnsNil
{
    // given
    sut = [[GHSUserRepositories alloc] initWithRepositories:@[]];
    
    // when
    GHSRepository *popularRepo = sut.popularRepository;
    
    // then
    XCTAssertNil(popularRepo, @"popularRepo should be nil");
}

- (void)testSeveralRepos_popularRepository_returnsRepoWithBiggestStargazersCount
{
    // given
    GHSRepository *zeroStarsRepo = [[GHSRepository alloc] initWithName:@"sad repo" ownerLogin:@"user" language:@"" shortDescription:@"" defaultBranch:@"" lastUpdate:nil forksCount:0 stargazersCount:0 openIssuesCount:0];
    GHSRepository *hundredStarsRepo = [[GHSRepository alloc] initWithName:@"cool repo" ownerLogin:@"user" language:@"" shortDescription:@"" defaultBranch:@"" lastUpdate:nil forksCount:0 stargazersCount:100 openIssuesCount:0];
    GHSRepository *thousandStarsRepo = [[GHSRepository alloc] initWithName:@"amazing repo" ownerLogin:@"user" language:@"" shortDescription:@"" defaultBranch:@"" lastUpdate:nil forksCount:0 stargazersCount:1000 openIssuesCount:0];
    sut = [[GHSUserRepositories alloc] initWithRepositories:@[zeroStarsRepo, thousandStarsRepo, hundredStarsRepo]];
    
    // when
    GHSRepository *popularRepo = sut.popularRepository;
    
    // then
    XCTAssertEqualObjects(popularRepo, thousandStarsRepo, @"Incorrect popularRepo, expected <%@>, was <%@>", popularRepo, thousandStarsRepo);
}

@end
