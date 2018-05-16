//
//  ReposManager.swift
//  ProjectMVCTests
//
//  Created by Edgar Costa Cardoso on 15/05/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import Nimble
import Quick

@testable import ProjectMVC

class ReposManagerSpec: QuickSpec {
    override func spec() {
        describe("ReposManager") {

            var manager = ReposManager()

            it("should load repos") {
                setManager(withJson: "Repos")
                var success = false
                manager.getRepos(page: 0) { result in
                    success = result
                }

                expect(success).toEventually(beTrue())
            }

            it("should NOT load repos") {
                setManager(shouldThrowError: true)
                var success = true
                manager.getRepos(page: 0) { result in
                    success = result
                }

                expect(success).toEventually(beFalse())
            }

            it("should give repo count") {
                setManager(withJson: "Repos")
                var count = 0
                manager.getRepos(page: 0) { _ in
                    count = manager.getRepoCount()
                }

                expect(count).toEventually(be(30))
            }

            it("should get a repo at index 10") {
                setManager(withJson: "Repos")
                var repo: Repo? = nil
                manager.getRepos(page: 0) { _ in
                    repo = manager.getRepo(at: 10)
                }

                expect(repo).toEventuallyNot(beNil())
                expect(repo?.name) == "Mint"
            }

            it("should return nil when giving unknown index") {
                setManager(withJson: "Repos")
                var repo: Repo? = Repo()
                manager.getRepos(page: 0) { _ in
                    repo = manager.getRepo(at: 50)
                }

                expect(repo).toEventually(beNil())
            }

            func setManager(withJson stringJson: String = "", shouldThrowError: Bool = false) {
                let json = Json(json: JsonHelper.readJson(name: stringJson))
                let networkMock = NetworkRequestMock(json: json, error: shouldThrowError)
                let githubRequest = GithubRequest(networkRequest: networkMock)
                manager = ReposManager(requestManager: githubRequest)
            }
        }
    }
}
