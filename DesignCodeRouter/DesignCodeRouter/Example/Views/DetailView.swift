//
//  DetailView.swift
//  DesignCodeRouter
//
//  Created by Olga Shilenko on 08.04.2021.
//

import SwiftUI

struct DetailView: View {
    var viewModel: DetailViewModel
    
    var body: some View {
        ZStack {
            Color(viewModel.color)
            
            Button(action: {
                viewModel.state = .rollBack
            }, label: {
                Text("Go back")
                    .font(.largeTitle)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15.0)
            })
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(viewModel: DetailViewModel(color: .blue))
    }
}
