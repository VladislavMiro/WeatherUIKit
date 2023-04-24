//
//  WeatherDataSection.swift
//  WeatherUIKit
//
//  Created by Vladislav Miroshnichenko on 18.04.2023.
//

import UIKit

final class WeatherDataSection: UIView {
    
    private let stackView = UIStackView()
    private let sectionFrame = CGRect(x: 0, y: 0, width: 80, height: 80)
    private var windSection: SectionElement!
    private var humiditySection: SectionElement!
    private var cloudSection: SectionElement!
      
    init(frame: CGRect, windData: String = "", humidityData: String = "", cloudData: String = "") {
        super.init(frame: frame)
        configureSection(windData: windData, humidityData: humidityData, cloudData: cloudData)
        configure()
        configureStackView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureSection(windData: "", humidityData: "", cloudData: "")
        configure()
        configureStackView()
    }
    
    override func layoutSubviews() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
        ])
    }
    
    private func configureSection(windData: String, humidityData: String, cloudData: String) {
        windSection = SectionElement(frame: sectionFrame, label: "Wind", data: windData, image: Resources.StandartImages.wind)
        humiditySection = SectionElement(frame: sectionFrame, label: "Humidity", data: humidityData, image: Resources.StandartImages.humidity)
        cloudSection = SectionElement(frame: sectionFrame, label: "Cloud", data: cloudData, image: Resources.StandartImages.cloud)
    }
    
    private func configure() {
        self.backgroundColor = Resources.Colors.secondBackground
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
    }
    
    private func configureStackView() {
        stackView.addArrangedSubview(windSection)
        stackView.addArrangedSubview(humiditySection)
        stackView.addArrangedSubview(cloudSection)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackView)
    }

}
