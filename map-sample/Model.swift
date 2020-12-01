//
//  Model.swift
//  map-sample
//
//  Created by Susumu Hoshikawa on 2020/12/01.
//

import SwiftUI
import MapKit

struct MapItem: Identifiable {
    var id = UUID().uuidString
    var coordinate = CLLocationCoordinate2D()
    var color = Color.red
}
