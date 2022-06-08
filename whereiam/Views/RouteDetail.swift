//
//  RouteDetail.swift
//  whereiam
//
//  Created by Yurii Troniak on 07.06.2022.
//

import SwiftUI

struct RouteDetail: View {
    @State private var directions: [String] = []
    @State private var showDirections = false
    
    var body: some View {
        ZStack{
            MapViewRoute(directions: $directions)
            VStack(){
                Spacer()
                Button{
                    showPrint()
                }label:{
                    Text("Create Route")
                }
                .disabled(directions.isEmpty)
                .padding()
                .background(Color("cyan"))
                .cornerRadius(10)
                .foregroundColor(.black)
                .shadow(color: Color.gray, radius: 3)
            }.sheet(isPresented: $showDirections, content: {
                VStack(spacing: 0) {
                  Text("Directions")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                  
                  Divider().background(Color.blue)
                  
                  List(0..<self.directions.count, id: \.self) { i in
                    Text(self.directions[i]).padding()
                  }
                }
              })
            .padding()
        }.ignoresSafeArea()
    }
    
    private func showPrint(){
        self.showDirections.toggle()
        print("button clicked")
    }
}

struct RouteDetail_Previews: PreviewProvider {
    static var previews: some View {
            RouteDetail()
    }
}
