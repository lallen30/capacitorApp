//
//  FirstScreen.swift
//  NativeNavigation
//
//  Created by Larry Allen on 4/18/23.
//

import UIKit
import MapboxDirections
import MapboxCoreNavigation
import MapboxNavigation

class FirstScreen: UIViewController {
    
    let nextButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        view.backgroundColor = .systemBackground
        title = "Navigation App"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        

        // Do any additional setup after loading the view.
    }
    
    
    func setupButton() {
        view.addSubview(nextButton)
        
        nextButton.configuration = .filled()
        nextButton.configuration?.baseBackgroundColor = .systemBlue
        nextButton.configuration?.title = "Start Navigation"
        
        nextButton.addTarget(self, action: #selector(goToNextScreen), for: .touchUpInside)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 200),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func goToNextScreen() {
        // Define two waypoints to travel between
        let origin = Waypoint(coordinate: CLLocationCoordinate2D(latitude: 35.92198082890392, longitude: -84.04930830286189), name: "Mapbox")
        let destination = Waypoint(coordinate: CLLocationCoordinate2D(latitude: 36.03617698582892, longitude: -83.8664466740223), name: "White House")
         
        // Set options
        let routeOptions = NavigationRouteOptions(waypoints: [origin, destination])
         
        // Request a route using MapboxDirections.swift
        Directions.shared.calculate(routeOptions) { [weak self] (session, result) in
            switch result {
                case .failure(let error):
                print(error.localizedDescription)
                case .success(let response):
                guard let self = self else { return }
                // Pass the first generated route to the the NavigationViewController
                let viewController = NavigationViewController(for: response, routeIndex: 0, routeOptions: routeOptions)
                viewController.modalPresentationStyle = .fullScreen
                self.present(viewController, animated: true, completion: nil)
            }
        }
    }

}
