//
//  MapViewModel.swift
//  map-sample
//
//  Created by Susumu Hoshikawa on 2020/12/01.
//

import SwiftUI
import MapKit
import Combine

final class MapViewModel: NSObject, ObservableObject {
    
    private let manager = CLLocationManager()
    
    // 初期表示の座標.
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 35.6812362,
            longitude: 139.7671248
        ),
        latitudinalMeters: 10_000,
        longitudinalMeters: 10_000
    )
    
    @Published var trackingMode: MapUserTrackingMode = .follow
    
    @Published var items: [MapItem] = []
    
    private var cancellable = Set<AnyCancellable>()
    
    override init() {
        super.init()
        manager.delegate = self
        
        $region
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { [weak self] region in
                let annotation = MapItem(coordinate: region.center, color: .blue)
                self?.items.append(annotation)
            }
            .store(in: &cancellable)
    }
    
    /// 位置情報のリクエスト.
    func requestUserLocation() {
        manager.startUpdatingLocation()
    }
    
    /// MapItemをクリア.
    func removeItems() {
        items.removeAll()
    }
}

extension MapViewModel: CLLocationManagerDelegate {
    
    // 位置情報関連の権限に変更があったら呼び出される.
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        
        if manager.authorizationStatus == .authorizedWhenInUse {
            print(#function, "権限があるので位置情報をリクエスト.")
            
            // 正確な位置情報を利用する権限があるかどうか.
            if manager.accuracyAuthorization != .fullAccuracy {
                // 正確な位置情報をリクエスト.
                manager.requestTemporaryFullAccuracyAuthorization(withPurposeKey: "full_accuracy_message")
            }
            
            manager.startUpdatingLocation()
        } else {
            print(#function, "権限がないので権限をリクエスト.")
            manager.requestWhenInUseAuthorization()
        }
    }
    
    // 位置情報が更新されたら呼び出される.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function)
        
        manager.stopUpdatingLocation()
        
        guard let location = locations.first else { return }
        
        // 取得した位置情報を reigon.center に与える.
        withAnimation {
            region.center = location.coordinate
        }
    }
}
