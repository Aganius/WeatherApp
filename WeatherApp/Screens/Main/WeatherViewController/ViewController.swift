//
//  ViewController.swift
//  WeatherApp
//
//  Created by Elioth Quintana on 14/03/23.
//

import UIKit

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = CurrentWeatherViewController().view!
        
        
        self.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            view.widthAnchor.constraint(equalToConstant: 200),
            view.heightAnchor.constraint(equalToConstant: 200),
            view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            view.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
        ]
        NSLayoutConstraint.activate(constraints)
        
        
        
    }


}

