//
//  DetailView.swift
//  DesignCodeRouter
//
//  Created by Olga Shilenko on 08.04.2021.
//

import SwiftUI

struct DetailView: View {
    var color: UIColor
    
    var body: some View {
        Rectangle()
            .foregroundColor(Color(color))
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(color: .blue)
    }
}
