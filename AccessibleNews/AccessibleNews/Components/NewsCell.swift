//
//  NewsCell.swift
//  AccessibleNews
//
//  Created by Luka Gazdeliani on 27.12.23.
//

import UIKit
import GenericNetworkLayer

final class NewsCell: UICollectionViewCell {
    // MARK: Properties
    
    private let mainStackView = UIStackView()
    
    private let newsImageView = UIImageView()
    
    private let newsTitleLabel = UILabel()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        setupConstraints()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder: NSCoder) has not been implemented")
    }
    
    // MARK: Prepare for reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        newsImageView.image = nil
        newsTitleLabel.text = nil
    }
    
    // MARK: Methods
    private func addSubViews() {
        contentView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(newsImageView)
        mainStackView.addArrangedSubview(newsTitleLabel)
    }
    
    private func setupConstraints() {
        setupMainStackViewConstraints()
        setupNewsImageViewConstraints()
        setupNewsTitleLabelConstraints()
    }
    
    private func setupUI() {
        setupMainStackViewUI()
        setupNewsImageViewUI()
        setupNewsTitleLabelUI()
    }
    
    func configureCell(with news: News) {
        downloadImage(with: news)
        newsTitleLabel.text = news.title
    }
    
    private func downloadImage(with news: News) {
        NetworkManager().downloadImage(from: news.image) { [weak self] image in
            DispatchQueue.main.async {
                self?.newsImageView.image = image
            }
        }
    }

    // MARK: Setup UI
    private func setupMainStackViewUI() {
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.isLayoutMarginsRelativeArrangement = true
        mainStackView.axis = .vertical
        mainStackView.spacing = 5
        mainStackView.alignment = .center
        mainStackView.backgroundColor = .lightGray.withAlphaComponent(0.2)
        mainStackView.layer.cornerRadius = 8
    }
    
    private func setupNewsImageViewUI() {
        newsImageView.layer.masksToBounds = true
        newsImageView.layer.cornerRadius = 8
        newsImageView.isAccessibilityElement = true
        newsImageView.accessibilityTraits = .image
        newsImageView.accessibilityLabel = "News Image"
    }
    
    private func setupNewsTitleLabelUI() {
        newsTitleLabel.adjustsFontForContentSizeCategory = true
        newsTitleLabel.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: .systemFont(ofSize: 10))
        newsTitleLabel.textAlignment = .left
        newsTitleLabel.textColor = .black
        newsTitleLabel.numberOfLines = 0
        newsTitleLabel.accessibilityLabel = "News Title: \(String(describing: newsTitleLabel.text))"
    }
    
    // MARK: Setup Constraints
    private func setupMainStackViewConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainStackView.widthAnchor.constraint(equalToConstant: 150),
            mainStackView.heightAnchor.constraint(equalToConstant: 230),
        ])
    }
    
    private func setupNewsImageViewConstraints() {
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: mainStackView.topAnchor, constant: 20),
            newsImageView.heightAnchor.constraint(equalToConstant: 100),
            newsImageView.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func setupNewsTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            newsTitleLabel.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 20),
            newsTitleLabel.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -20),
        ])
    }
}
