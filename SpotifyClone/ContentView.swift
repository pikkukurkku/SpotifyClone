//
//  ContentView.swift
//  SpotifyClone
//
//  Created by Natalia Ogorek on 28.03.25.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct ContentView: View {

    @Environment(\.router) var router

    var body: some View {
        List {
            Button("Open Spotify") {
                router.showScreen(.fullScreenCover) { _ in
                    SpotifyHomeView()
                }
            }
        }
    }
}

#Preview {
    RouterView { _ in
        ContentView()
    }
}
