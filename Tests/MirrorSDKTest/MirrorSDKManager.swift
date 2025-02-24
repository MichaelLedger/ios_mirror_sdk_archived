//
//  MirrorSDKTestManager.swift
//  MirrorSDK
//
//  Created by Gavin Xiang on 12/18/24.
//

import BBBadgeBarButtonItem
import BCMeshTransformView

@MainActor
@objcMembers public class MirrorSDKTestManager: NSObject {
    
    public static let shared = MirrorSDKTestManager()
    
    public func testBBBadgeBarButtonItem() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        print("\(#function)")
        let item = BBBadgeBarButtonItem(barButtonSystemItem: .bookmarks, target: nil, action: nil)
        item.badgeValue = "10"
    }
    
    public func testBCMeshTransformView() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        print("\(#function)")
        let _ = BCMeshTransformView()
    }
    
}
