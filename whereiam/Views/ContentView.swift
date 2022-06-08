//
//  ContentView.swift
//  whereiam
//
//  Created by Yurii Troniak on 06.06.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        LandmarkList()
        RouteDetail()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ModelData())
    }
}
