//
//  MapViewModel.swift
//  map-sample
//
//  Created by Susumu Hoshikawa on 2020/12/01.
//

import SwiftUI
import MapKit

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
    
    override init() {
        super.init()
        manager.delegate = self
    }
}

extension MapViewModel: CLLocationManagerDelegate {
    
    // 位置情報関連の権限に変更があったら呼び出される.
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
    }
}
