//
//  MainView.swift
//  WeatherUIKit
//
//  Created by Vladislav Miroshnichenko on 17.04.2023.
//

import UIKit
import MapKit
import Combine

final class MainView: UIViewController {
    
    private var header: HeaderView!
    private var section: WeatherDataSection!
    private let forecastList = ForecastListView()
    private let map = MKMapView()
    private let scrollView = UIScrollView()
    private var cancellable = Set<AnyCancellable>()
    private var viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureConstraints()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    private func bind() {
        
        viewModel.$weather.sink(receiveValue: { data in
            self.header.data =  data.headerOutputModel
            self.section.data = data.weatherDataSectionModel
            self.forecastList.data = data.forecast
            self.map.setRegion(data.location, animated: true)
            self.scrollView.refreshControl?.endRefreshing()
        }).store(in: &cancellable)
        
        viewModel.$errorMessage.sink { error in
            self.showAlert(message: error)
            self.scrollView.refreshControl?.endRefreshing()
        }.store(in: &cancellable)

    }
    
    private func configureView() {
        scrollView.backgroundColor = Resources.Colors.background
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        scrollView.frame = UIScreen.main.bounds
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.tintColor = .white
        scrollView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        header = HeaderView(frame: .init(x: 0, y: 0,
                                         width: self.view.bounds.width,
                                         height: 160))
        section = WeatherDataSection(frame: .init(x: 0, y: 0,
                                                  width: self.view.bounds.width,
                                                  height: 100))
        
        map.layer.cornerRadius = 15
        map.mapType = .standard
        
        forecastList.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 200)

        header.translatesAutoresizingMaskIntoConstraints = false
        section.translatesAutoresizingMaskIntoConstraints = false
        forecastList.translatesAutoresizingMaskIntoConstraints = false
        map.translatesAutoresizingMaskIntoConstraints = false

        scrollView.addSubview(header)
        scrollView.addSubview(section)
        scrollView.addSubview(forecastList)
        scrollView.addSubview(map)
        
        view.addSubview(scrollView)
    }
    
    private func configureConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            header.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 30),
            header.leadingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.trailingAnchor),
            header.heightAnchor.constraint(equalToConstant: 160),
            
            section.topAnchor.constraint(equalTo: self.header.bottomAnchor, constant: 15),
            section.leadingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.leadingAnchor),
            section.trailingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.trailingAnchor),
            section.heightAnchor.constraint(equalToConstant: 100),
            
            forecastList.topAnchor.constraint(equalTo: section.bottomAnchor, constant: 15),
            forecastList.leadingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.leadingAnchor),
            forecastList.trailingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.trailingAnchor),
            forecastList.heightAnchor.constraint(equalToConstant: 150),
            
            map.topAnchor.constraint(equalTo: forecastList.bottomAnchor, constant: 10),
            map.leadingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.leadingAnchor),
            map.trailingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.trailingAnchor),
            map.heightAnchor.constraint(equalToConstant: 200),
            map.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    @objc private func refreshData() {
        self.viewModel.requestWeather()
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
