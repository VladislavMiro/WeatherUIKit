//
//  SegmentedControl.swift
//  WeatherUIKit
//
//  Created by Vladislav Miroshnichenko on 19.04.2023.
//

import UIKit

final class SegmentedControl: UISegmentedControl {

    private let selectedDot = UIView()
    private lazy var dotPos: NSLayoutConstraint = {
        return selectedDot.centerXAnchor.constraint(equalTo: self.centerXAnchor)
    }()

    override init(items: [Any]?) {
        super.init(items: items)
        configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        NSLayoutConstraint.activate([
            selectedDot.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 10),
            selectedDot.heightAnchor.constraint(equalToConstant: 5),
            selectedDot.widthAnchor.constraint(equalToConstant: 5),
            dotPos
        ])

    }
    
    private func configure() {
        selectedSegmentIndex = 0
        setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        setTitleTextAttributes([.foregroundColor: UIColor.lightGray], for: .normal)
        setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        addTarget(self, action: #selector(valueChanged), for: .valueChanged)
        
        selectedDot.backgroundColor = .white
        selectedDot.frame = .init(x: 0, y: 0, width: 5, height: 5)
        selectedDot.layer.cornerRadius = selectedDot.bounds.height / 2
        selectedDot.translatesAutoresizingMaskIntoConstraints = false
        addSubview(selectedDot)

        dotPos.constant = -bounds.midX / 2
    }
    
    @objc private func valueChanged() {
        let midSegment = self.bounds.midX / 2
        
        layoutIfNeeded()
        
        switch selectedSegmentIndex {
        case 0:
            animation(position: -midSegment)
        case 1:
            animation(position: midSegment)
        default:
            animation(position: -midSegment)
        }
    }
    
    private func animation(position: CGFloat) {
        UIView.animate(withDuration: 0.3) { [position, self] in
            self.dotPos.constant = position
            self.layoutIfNeeded()
        }
    }

}
