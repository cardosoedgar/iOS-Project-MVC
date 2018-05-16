//
//  PullRequestManagerSpec.swift
//  ProjectMVCTests
//
//  Created by Edgar Costa Cardoso on 15/05/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import Nimble
import Quick

@testable import ProjectMVC

//swiftlint:disable function_body_length
class PullRequestManagerSpec: QuickSpec {
    override func spec() {
        describe("PullRequestManager") {

            var manager = PullRequestsManager(repo: Repo())

            it("should load pull requests") {
                setManager(withJson: "PullRequest")
                var success = false
                manager.getPullRequests { result in
                    success = result
                }

                expect(success).toEventually(beTrue())
            }

            it("should NOT load pull requests") {
                setManager(shouldThrowError: true)
                var success = true
                manager.getPullRequests { result in
                    success = result
                }

                expect(success).toEventually(beFalse())
            }

            it("should give pull request count") {
                setManager(withJson: "PullRequest")
                var count = 0
                manager.getPullRequests { _ in
                    count = manager.getPullRequestCount()
                }

                expect(count).toEventually(be(7))
            }

            it("should get a pull request at index 3") {
                setManager(withJson: "PullRequest")
                var pullRequest: PullRequest? = nil
                manager.getPullRequests { _ in
                    pullRequest = manager.getPullRequest(at: 3)
                }

                expect(pullRequest).toEventuallyNot(beNil())
                expect(pullRequest?.title) == "Add CodeTriage badge to alamofire/alamofire"
            }

            it("should return nil when giving unknown index") {
                setManager(withJson: "PullRequest")
                var repo: PullRequest? = PullRequest()
                manager.getPullRequests { _ in
                    repo = manager.getPullRequest(at: 100)
                }

                expect(repo).toEventually(beNil())
            }

            it("should get repo name") {
                setManager(withJson: "PullRequest")
                expect(manager.getRepoName()) == "RepoName"
            }

            func setManager(withJson stringJson: String = "", shouldThrowError: Bool = false) {
                let json = Json(json: JsonHelper.readJson(name: stringJson))
                let networkMock = NetworkRequestMock(json: json, error: shouldThrowError)
                let githubRequest = GithubRequest(networkRequest: networkMock)
                manager = PullRequestsManager(repo: Repo(name: "RepoName"), requestManager: githubRequest)
            }
        }
    }
}
