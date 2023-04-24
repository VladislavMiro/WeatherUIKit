//
//  ForecastCell.swift
//  WeatherUIKit
//
//  Created by Vladislav Miroshnichenko on 21.04.2023.
//

import UIKit

final class ForecastCell: UICollectionViewCell {
    
    private let timeLabel = UILabel()
    private let dataLabel = UILabel()
    private let image = UIImageView()
    private let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        configureLabel()
        configureImageView()
        configureStackView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureCell()
        configureLabel()
        configureImageView()
        configureStackView()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func configureCell() {
        backgroundColor = Resources.Colors.secondBackground
        layer.cornerRadius = 15
    }
    
    private func configureLabel() {
        timeLabel.text = "12 am"
        timeLabel.textColor = .lightGray
        timeLabel.font = UIFont(name: Resources.Fonts.RussoOneRegular, size: 12)
        timeLabel.numberOfLines = 1
        
        dataLabel.text = "16º"
        dataLabel.textColor = .white
        dataLabel.font = UIFont(name: Resources.Fonts.RussoOneRegular, size: 12)
        dataLabel.numberOfLines = 1
    }
    
    private func configureImageView() {
        image.image = UIImage(systemName: "cloud.fill")
        image.contentMode = .scaleAspectFill
    }
    
    private func configureStackView() {
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(timeLabel)
        stackView.addArrangedSubview(image)
        stackView.addArrangedSubview(dataLabel)
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(stackView)
    }
    
}
