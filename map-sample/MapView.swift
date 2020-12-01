//
//  MapView.swift
//  map-sample
//
//  Created by Susumu Hoshikawa on 2020/12/01.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @StateObject private var viewModel = MapViewModel()
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
            
            Map(
                coordinateRegion: $viewModel.region,
                interactionModes: .all,
                showsUserLocation: true,
                userTrackingMode: $viewModel.trackingMode,
                annotationItems: viewModel.items
            ) { item in
                MapAnnotation(
                    coordinate: item.coordinate,
                    anchorPoint: CGPoint(x: 0.5, y: 1.0)
                ) {
                    MapAnnotationView(item: item)
                }
            }
            .ignoresSafeArea()
            
            HStack(spacing: 24.0) {
                
                // MapItemのクリアボタン.
                Button(action: {
                    viewModel.removeItems()
                }, label: {
                    Image(systemName: "mappin.slash")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 44.0, height: 44.0)
                })
                
                // 位置情報リクエストボタン.
                Button(action: {
                    viewModel.requestUserLocation()
                }, label: {
                    Image(systemName: "dot.circle.and.cursorarrow")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 44.0)
                })
            }
            .padding(24.0)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
