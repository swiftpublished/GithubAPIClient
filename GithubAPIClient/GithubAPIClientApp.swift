//
//  GithubAPIClientApp.swift
//  GithubAPIClient
//
//  Created by Muralidharan Kathiresan on 01/10/23.
//

import SwiftUI

@main
struct GithubAPIClientApp: App {
    var body: some Scene {
        WindowGroup {
            /// Vanilla SwiftUI
//            Root(model: .init())
            
            /// TCA SwiftUI
            if !_XCTIsTesting {
                Root(
                    store: Store(initialState: AppFeature.State()) {
                        AppFeature()
                    }
                )
            }
        }
    }
}
