//
//  RecipeSlideShow.swift
//  Recipes
//
//  Created by Ryan Lin on 4/14/25.
//

import Foundation

import SwiftUI

struct RecipeSlideshowView: View {
    let imageURLs: [String]
    @State private var selection: Int = 0
    @State private var showFullScreen: Bool = false

    var body: some View {
        VStack {
            TabView(selection: $selection) {
                ForEach(Array(imageURLs.enumerated()), id: \.offset) { index, url in
                    AsyncImage(url: URL(string: url)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .clipped()
                        case .failure:
                            Color.gray.overlay(Text("No Image"))
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .tag(index)
                    .frame(height: 300) 
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .frame(height: 300)
            .onTapGesture {
                showFullScreen = true
            }
            .fullScreenCover(isPresented: $showFullScreen) {
                FullScreenImageGalleryView(imageURLs: imageURLs, initialIndex: selection)
            }
        }
    }
}
