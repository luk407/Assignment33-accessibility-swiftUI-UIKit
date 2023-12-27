//
//  CollectionViewRepresentable.swift
//  AccessibleNews
//
//  Created by Luka Gazdeliani on 27.12.23.
//

import SwiftUI

struct CollectionViewRepresentable: UIViewRepresentable {
    
    // MARK: Properties
    @ObservedObject var newsViewModel: NewsViewModel
    
    // MARK: Methods
    func makeUIView(context: Context) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(NewsCell.self, forCellWithReuseIdentifier: "NewsCell")
        collectionView.dataSource = context.coordinator
        
        return collectionView
    }
    
    func updateUIView(_ uiView: UICollectionView, context: Context) {
        context.coordinator.newsViewModel = newsViewModel
        uiView.reloadData()
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(newsViewModel: newsViewModel)
    }
    
    final class Coordinator: NSObject, UICollectionViewDataSource, ObservableObject {
        @ObservedObject var newsViewModel: NewsViewModel
        
        init(newsViewModel: NewsViewModel) {
            self.newsViewModel = newsViewModel
        }
        
        @MainActor
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            newsViewModel.newsArray.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath)
            let news = newsViewModel.newsArray[indexPath.row]
            
            if let newsCell = cell as? NewsCell {
                newsCell.configureCell(with: news)
            }
            return cell
        }
    }
}
