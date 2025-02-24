//
//  MirrorSDK.swift
//  SPMTest
//
//  Created by Gavin Xiang on 12/17/24.
//

import Testing
import XCTest
@MainActor
struct Test {

    @Test func testPerformance() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        print("\(#function)")
        let shared = MirrorSDKTestManager.shared
        do {
            try await shared.testBCMeshTransformView()
        } catch {
            XCTAssert(false, error.localizedDescription)
        }
        do {
            try await shared.testBBBadgeBarButtonItem()
        } catch {
            XCTAssert(false, error.localizedDescription)
        }
        
        XCTAssert(true, "Pass");
    }

}
