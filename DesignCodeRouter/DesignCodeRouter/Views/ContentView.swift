//
//  ContentView.swift
//  DesignCodeRouter
//
//  Created by Olga Shilenko on 06.04.2021.
//

import SwiftUI

struct ContentView: View {
    @State var viewModel: ContentViewModel
    
    var body: some View {
        VStack {
            Text("Choose the color")
                .font(.title)

            HStack {
                ForEach(0..<viewModel.colors.count) { colorIndex in
                    Button(action: {
                        let color = viewModel.colors[colorIndex]
                        let destination = DetailDestination.detailView(color: color)

                        viewModel.state = .navigate(destination: destination)
                    }, label: {
                        Rectangle()
                            .fill(Color(viewModel.colors[colorIndex]))
                            .frame(width: 50, height: 50)
                    })
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var viewModel = ContentViewModel()
    
    static var previews: some View {
        ContentView(viewModel: viewModel)
    }
}
