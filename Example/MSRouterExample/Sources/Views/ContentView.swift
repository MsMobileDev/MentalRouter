//
//  ContentView.swift
//  MSRouter
//
//  Created by Olga Shilenko on 06.04.2021.
//

import SwiftUI
import MSRouter

struct ContentView: View {
    @State var viewModel: ContentViewModel
    
    var body: some View {
        VStack {
            SettingsView(viewModel: $viewModel.settingsViewModel)
                .padding(.vertical, 20.0)
            
            Text("Go to colored view")
                .font(.system(size: 16.0))
            
            HStack {
                ForEach(0..<viewModel.colors.count) { colorIndex in
                    GeometryReader { geometry in
                        Button(action: {
                            let color = viewModel.colors[colorIndex]
                            let destination = DetailDestination.detailView(color: color)
                            let originRect = geometry.frame(in: .global)
                            let transition = configureTransition(originRect: originRect)
                            
                            viewModel.state = .navigate(destination: destination, transition: transition)
                        }, label: {
                            Rectangle()
                                .fill(Color(viewModel.colors[colorIndex]))
                        })
                    }
                    .frame(width: 50, height: 50)
                }
            }
            .padding(.vertical, 15)
            
            Text("or")
            
            GeometryReader { geometry in
                Button(action: {
                    let destination = ControllerDestination.simpleText
                    let originRect = geometry.frame(in: .global)
                    let transition = configureTransition(originRect: originRect)
                    
                    viewModel.state = .navigate(destination: destination, transition: transition)
                }, label: {
                    Text("Go to simple controller")
                        .padding()
                        .background(Color(UIColor.lightGray.withAlphaComponent(0.2)))
                        .cornerRadius(20.0)
                        .clipped()
                        .padding()
                })
                .frame(width: geometry.size.width)
            }
            .frame(maxHeight: 85)
        }
        .padding()
    }
}

// MARK: Public methods
extension ContentView {
    func configureTransition(originRect: CGRect) -> MSNavigationTransition {
        let viewCenter = CGPoint(x: originRect.midX, y: originRect.midY)
        
        return MSNavigationTransition(
            presented: ScaleTransition(duration: 0.6, scale: 1.0, center: viewCenter),
            dismissed: ScaleTransition(duration: 0.6, scale: 0.0, center: viewCenter)
        )
    }
}

// MARK: Preview
struct ContentView_Previews: PreviewProvider {
    static var viewModel = ContentViewModel()
    
    static var previews: some View {
        Group {
            ContentView(viewModel: viewModel)
        }
    }
}
