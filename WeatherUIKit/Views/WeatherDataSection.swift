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
    
    public var data: MainViewModelOutputModels.WeatherDataSectionModel = .init() {
        didSet {
            setData(windData: data.windData, humidityData: data.humidityData, cloudData: data.cloudData)
        }
    }
    
    init(frame: CGRect, windData: String = "", humidityData: String = "", cloudData: String = "") {
        super.init(frame: frame)
        configureSection()
        configure()
        configureStackView()
        setData(windData: windData, humidityData: humidityData, cloudData: cloudData)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureSection()
        configure()
        configureStackView()
        setData()
    }
    
    override func layoutSubviews() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
        ])
    }
    
    private func setData(windData: String = "", humidityData: String = "", cloudData: String = "") {
        self.windSection.data = windData
        self.humiditySection.data = humidityData
        self.cloudSection.data = cloudData
    }
    
    private func configureSection() {
        windSection = SectionElement(frame: sectionFrame, label: "Wind", image: Resources.StandartImages.wind)
        humiditySection = SectionElement(frame: sectionFrame, label: "Humidity", image: Resources.StandartImages.humidity)
        cloudSection = SectionElement(frame: sectionFrame, label: "Cloud", image: Resources.StandartImages.cloud)
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
