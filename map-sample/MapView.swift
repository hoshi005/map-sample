//
//  MapView.swift
//  map-sample
//
//  Created by Susumu Hoshikawa on 2020/12/01.
//

import SwiftUI

struct MapView: View {
    
    @StateObject private var viewModel = MapViewModel()
    
    var body: some View {
        Text("Hello, World!")
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
