//
//  HeaderView.swift
//  WeatherUIKit
//
//  Created by Vladislav Miroshnichenko on 17.04.2023.
//

import UIKit
import Combine

final class HeaderView: UIView {
    
    public var data = MainViewModelOutputModels.HeaderModel() {
        didSet {
            setData()
        }
    }
    public var isDay: Bool = true
    
    private let cityLabel = UILabel()
    private let dateLabel = UILabel()
    private let labelStack = UIStackView()
    private let weatherLabel = UILabel()
    private let statementLabel = UILabel()
    private let weatherLabelStack = UIStackView()
    private let weatherDataStack = UIStackView()
    private let image = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLabels()
        configureImage()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureLabels()
        configureImage()
    }
    
    private func setData() {
        cityLabel.text = data.cityName
        dateLabel.text = data.date
        weatherLabel.text = data.temp
        statementLabel.text = data.condition
        image.image = UIImage(named: data.icon)
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

        cityLabel.textAlignment = .left
        cityLabel.textColor = .white
        cityLabel.font = UIFont(name: Resources.Fonts.RussoOneRegular, size: 24)
        
        dateLabel.textAlignment = .left
        dateLabel.textColor = .lightGray
        dateLabel.font = .systemFont(ofSize: 12, weight: .light)
        
        weatherLabel.textAlignment = .left
        weatherLabel.textColor = .white
        weatherLabel.font = UIFont(name: Resources.Fonts.RussoOneRegular, size: 56)
        
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
        image.contentMode = .scaleAspectFill
        
        self.addSubview(image)
    }
}
