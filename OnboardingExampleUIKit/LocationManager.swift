//
//  LocationManager.swift
//  OnboardingExampleUIKit
//
//  Created by Dane Thomas on 10/11/20.
//

import Foundation
import CoreLocation

protocol CLLocationManageable {

    var delegate: CLLocationManagerDelegate? { get set }
    init()
    static func authorizationStatus() -> CLAuthorizationStatus
    func requestLocation()
    func requestWhenInUseAuthorization()
    static func locationServicesEnabled() -> Bool
}

extension CLLocationManager: CLLocationManageable {}

public class LocationManager: NSObject, CLLocationManagerDelegate {

    private lazy var manager: CLLocationManageable = {
        var manager = self.locationManagerType.init()
        manager.delegate = self
        return manager
    }()

    private let locationManagerType: CLLocationManageable.Type

    public override init() {
        self.locationManagerType = CLLocationManager.self
        super.init()
    }

    init(locationManagerType: CLLocationManageable.Type) {
        self.locationManagerType = locationManagerType
        super.init()
    }

    private var authCompletionHandler: ((Bool) -> Void)?
    private var locationCompletionHandler: ((CLLocation?) -> Void)?

    public func authorizationStatus() -> CLAuthorizationStatus {
        return type(of: self.manager).authorizationStatus()
    }

    public func locationServicesEnabled() -> Bool {
        return type(of: self.manager).locationServicesEnabled()
    }

    public func requestAuthorization(completion: @escaping (Bool) -> Void) {
        let status = type(of: self.manager).authorizationStatus()
        switch status {
        case .notDetermined:
            self.showAuthPrompt(completion: completion)
        case .restricted:
            completion(false)
        case .denied:
            completion(false)
        case .authorizedAlways:
            completion(true)
        case .authorizedWhenInUse:
            completion(true)
        @unknown default:
            completion(false)
        }
    }

    ///Must call showAuthPrompt(completion:) first before fetching location
    public func fetchLocation(completion: @escaping (CLLocation?) -> Void) {
        self.locationCompletionHandler = completion
        self.manager.requestLocation()
    }

    private func showAuthPrompt(completion: @escaping (Bool) -> Void) {
        self.authCompletionHandler = completion
        self.manager.requestWhenInUseAuthorization()

    }

    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            break
        case .restricted:
            self.authCompletionHandler?(false)
            self.authCompletionHandler = nil
        case .denied:
            self.authCompletionHandler?(false)
            self.authCompletionHandler = nil
        case .authorizedAlways:
            self.authCompletionHandler?(true)
            self.authCompletionHandler = nil
        case .authorizedWhenInUse:
            self.authCompletionHandler?(true)
            self.authCompletionHandler = nil
        @unknown default:
            self.authCompletionHandler?(false)
            self.authCompletionHandler = nil
        }
    }

    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locationCompletionHandler?(locations.last)
        self.locationCompletionHandler = nil
    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
