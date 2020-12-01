//
//  MapAnnotationView.swift
//  map-sample
//
//  Created by Susumu Hoshikawa on 2020/12/01.
//

import SwiftUI

struct MapAnnotationView: View {
    
    var item: MapItem
    
    var body: some View {
        
        Image(systemName: "bubble.middle.bottom.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 44.0)
            .foregroundColor(item.color)
            .shadow(color: Color.black.opacity(0.5), radius: 5, x: 5, y: 5)
    }
}

struct MapAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        MapAnnotationView(item: MapItem())
            .previewLayout(.fixed(width: 200.0, height: 200.0))
    }
}
