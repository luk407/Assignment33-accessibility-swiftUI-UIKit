//
//  ContentView.swift
//  AccessibleNews
//
//  Created by Luka Gazdeliani on 27.12.23.
//

import SwiftUI

struct NewsView: View {
    // MARK: Properties
    @ObservedObject var newsViewModel = NewsViewModel()
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    // MARK: Body
    var body: some View {
        VStack {
            CollectionViewRepresentable(newsViewModel: newsViewModel)
                .dynamicTypeSize(DynamicTypeSize.xSmall...DynamicTypeSize.xxxLarge)
        }
        .padding()
        .task {
            newsViewModel.fetchNewsData()
        }
    }
}




#Preview {
    NewsView()
}
