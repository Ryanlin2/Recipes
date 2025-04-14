//
//  FullScreenImageGalleryView.swift
//  Recipes
//
//  Created by Ryan Lin on 4/14/25.
//

import Foundation

import SwiftUI

struct FullScreenImageGalleryView: View {
    let imageURLs: [String]
    @State var currentIndex: Int
    @Environment(\.dismiss) var dismiss

    init(imageURLs: [String], initialIndex: Int) {
        self.imageURLs = imageURLs
        _currentIndex = State(initialValue: initialIndex)
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            TabView(selection: $currentIndex) {
                ForEach(Array(imageURLs.enumerated()), id: \.offset) { index, url in
                    AsyncImage(url: URL(string: url)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .tag(index)
                        case .failure:
                            Color.gray
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .tag(index)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .background(Color.black)
            
            Button(action: { dismiss() }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.white)
                    .font(.system(size: 32))
                    .padding(12)
                    .background(Color.black.opacity(0.5))
                    .clipShape(Circle())
                    .padding(.top, 40)
                    .padding(.trailing, 20)
            }
            .offset(y: 20) // push it lower
        }
        .ignoresSafeArea()
    }
}
