//
//  ForecastListView.swift
//  WeatherUIKit
//
//  Created by Vladislav Miroshnichenko on 18.04.2023.
//

import UIKit

final class ForecastListView: UIView {
        
    private var forecastList: UICollectionView!
    private var segmentedControl: SegmentedControl!
    
    public var data: MainViewModelOutputModels.Forecasts = .init() {
        didSet {
            forecastList.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSegmentedControl()
        configureForecastList()
        forecastList.register(ForecastCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureSegmentedControl()
        configureForecastList()
        forecastList.register(ForecastCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    override func layoutSubviews() {
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: self.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            segmentedControl.widthAnchor.constraint(equalToConstant: 150),
            segmentedControl.heightAnchor.constraint(equalToConstant: 30),
            
            forecastList.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            forecastList.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            forecastList.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            forecastList.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    private func configureForecastList() {
        let layout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 1, left: 10, bottom: 1, right: 10)
        layout.itemSize = CGSize(width: 80, height: 100)
        layout.scrollDirection = .horizontal
        
        forecastList = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        forecastList.collectionViewLayout = layout
        forecastList.delegate = self
        forecastList.backgroundColor = Resources.Colors.background
        forecastList.dataSource = self
        forecastList.translatesAutoresizingMaskIntoConstraints = false
        forecastList.showsHorizontalScrollIndicator = false
        
        self.addSubview(forecastList)
        
    }
    
    private func configureSegmentedControl() {
        segmentedControl = SegmentedControl(items: ["Today", "On Week"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(segmentedControlAction(sender:)), for: .valueChanged)
        self.addSubview(segmentedControl)
    }
    
    @objc private func segmentedControlAction(sender: UISegmentedControl) {
        UIView.animate(withDuration: 0.3) {
            self.forecastList.reloadData()
        }
    }
}

extension ForecastListView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return data.forecaastOnWeek.count
        case 1:
            return data.forecastByHour.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = forecastList.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? ForecastCell else { return UICollectionViewCell() }
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            let item = data.forecaastOnWeek[indexPath.row]
            cell.setData(time: item.date, data: item.temp, icon: item.icon)
        case 1:
            let item = data.forecastByHour[indexPath.row]
            cell.setData(time: item.date, data: item.temp, icon: item.icon)
        default:
            return cell
        }
        
        return cell
    }
    
    
}
