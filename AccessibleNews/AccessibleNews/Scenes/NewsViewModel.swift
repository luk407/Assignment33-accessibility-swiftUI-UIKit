//
//  NewsViewModel.swift
//  AccessibleNews
//
//  Created by Luka Gazdeliani on 27.12.23.
//

import SwiftUI
import GenericNetworkLayer

final class NewsViewModel: ObservableObject {
    // MARK: Properties
    private var url = URL(string: "https://api.worldnewsapi.com/search-news?api-key=af5f599c097240529042213f55902765&max-sentiment=-0.4&news-sources=https%3A%2F%2Fwww.huffingtonpost.co.uk#")!
    
    @Published var newsArray: [News] = []
    
    @Published var downloadedImage: UIImage?
    
    // MARK: Methods
    func fetchNewsData() {
        NetworkManager().request(with: url) { (result: Result<NewsData, Error>) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.newsArray = data.news
                }
            case .failure( _):
                break
            }
        }
    }
    
    func downloadImage(urlString: String) -> UIImage {
        NetworkManager().downloadImage(from: urlString) { image in
            DispatchQueue.main.async {
                self.downloadedImage = image!
            }
        }
        return downloadedImage ?? UIImage(systemName: "circle")!
    }
}
