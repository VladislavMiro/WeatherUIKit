//
//  SectionElement.swift
//  WeatherUIKit
//
//  Created by Vladislav Miroshnichenko on 18.04.2023.
//

import UIKit

final class SectionElement: UIView {
    
    private let imageView = UIImageView()
    private let label = UILabel()
    private let dataLabel = UILabel()
    private let stackView = UIStackView()
    
    init(frame: CGRect, label: String = "", data: String = "", image: UIImage? = .init()) {
        super.init(frame: frame)
        
        self.label.text = label
        self.dataLabel.text = data
        self.imageView.image = image
        
        configureImage()
        configureLabels()
        configureStackView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureImage()
        configureLabels()
        configureStackView()
    }
    
    override func layoutSubviews() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
        ])
    }
    
    private func configureLabels() {
        dataLabel.textColor = .white
        dataLabel.font = .systemFont(ofSize: 14)
        dataLabel.textAlignment = .center
        
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
    }
    
    private func configureImage() {
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
    }
    
    private func configureStackView() {
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 3
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(dataLabel)
        stackView.addArrangedSubview(label)

        addSubview(stackView)
    }
    
}
