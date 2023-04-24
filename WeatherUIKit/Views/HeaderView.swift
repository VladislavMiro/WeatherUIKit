//
//  HeaderView.swift
//  WeatherUIKit
//
//  Created by Vladislav Miroshnichenko on 17.04.2023.
//

import UIKit

final class HeaderView: UIView {
    
    private var cityName: String
    private var date: String
    
    private let cityLabel = UILabel()
    private let dateLabel = UILabel()
    private let labelStack = UIStackView()
    private let weatherLabel = UILabel()
    private let statementLabel = UILabel()
    private let weatherLabelStack = UIStackView()
    private let weatherDataStack = UIStackView()
    private let image = UIImageView()
    
    init(frame: CGRect, cityName: String, date: String) {
        self.cityName = cityName
        self.date = date
        super.init(frame: frame)
        configureLabels()
        configureImage()
    }
    
    required init?(coder: NSCoder) {
        cityName = ""
        date = ""
        super.init(coder: coder)
        configureLabels()
        configureImage()
    }
    
    override func layoutSubviews() {
       NSLayoutConstraint.activate([
            labelStack.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            labelStack.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            labelStack.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),

            image.widthAnchor.constraint(equalToConstant: 128),
            image.heightAnchor.constraint(equalToConstant: 96),
            image.topAnchor.constraint(equalTo: labelStack.bottomAnchor, constant: 25),
            image.trailingAnchor.constraint(equalTo: labelStack.trailingAnchor),
            
            weatherLabelStack.topAnchor.constraint(equalTo: image.topAnchor),
            weatherLabelStack.leadingAnchor.constraint(equalTo: labelStack.leadingAnchor),
            weatherLabelStack.trailingAnchor.constraint(equalTo: image.leadingAnchor)
        ])
    }
    
    private func configureLabels() {
        cityLabel.text = cityName
        cityLabel.textAlignment = .left
        cityLabel.textColor = .white
        cityLabel.font = UIFont(name: Resources.Fonts.RussoOneRegular, size: 24)
        
        dateLabel.text = date
        dateLabel.textAlignment = .left
        dateLabel.textColor = .lightGray
        dateLabel.font = .systemFont(ofSize: 12, weight: .light)
        
        weatherLabel.text = "18º"
        weatherLabel.textAlignment = .left
        weatherLabel.textColor = .white
        weatherLabel.font = UIFont(name: Resources.Fonts.RussoOneRegular, size: 56)
        
        statementLabel.text = "Thundertorm"
        statementLabel.textAlignment = .left
        statementLabel.textColor = .lightGray
        statementLabel.font = .systemFont(ofSize: 12, weight: .light)
        
        labelStack.addArrangedSubview(cityLabel)
        labelStack.addArrangedSubview(dateLabel)
        labelStack.axis = .vertical
        labelStack.distribution = .equalSpacing
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        
        weatherLabelStack.addArrangedSubview(weatherLabel)
        weatherLabelStack.addArrangedSubview(statementLabel)
        weatherLabelStack.axis = .vertical
        weatherLabelStack.distribution = .equalSpacing
        weatherLabelStack.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(labelStack)
        self.addSubview(weatherLabelStack)
    }
    
    private func configureImage() {
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "cloud.fill")
        image.contentMode = .scaleToFill
        
        self.addSubview(image)
    }

}
