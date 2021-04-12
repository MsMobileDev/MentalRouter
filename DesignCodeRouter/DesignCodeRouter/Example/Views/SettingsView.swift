//
//  SettingsView.swift
//  DesignCodeRouter
//
//  Created by Olga Shilenko on 12.04.2021.
//

import SwiftUI

struct SettingsView: View {
    @Binding var viewModel: SettingsViewModel
    
    var body: some View {
        VStack {
            Text("Presentation mode")
            Picker("PresentationMode", selection: $viewModel.presentationMode) {
                ForEach(SettingsViewModel.PresentationMode.allCases) { presentationMode in
                    Text(presentationMode.description)
                        .tag(presentationMode)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            if viewModel.presentationMode == .present {
                GeometryReader { geometry in
                    VStack {
                        Text("Presentation style")
                        Picker("ModalPresentationMode", selection: $viewModel.modalPresentationStyle) {
                            ForEach(SettingsViewModel.ModalPresentationStyle.allCases) { presentationStyle in
                                Text(presentationStyle.description)
                                    .tag(presentationStyle)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()

                        Text("Transition style")
                        VStack {
                            Picker("ModalTransiotionStyle", selection: $viewModel.modalTransitionStyle) {
                                ForEach(SettingsViewModel.ModalTransitionStyle.allCases) { transitionStyle in
                                    Text(transitionStyle.description)
                                        .tag(transitionStyle)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                    }
                    .padding()
                    .frame(width: geometry.size.width)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25.0)
                            .stroke(Color.gray, lineWidth: 1.0)
                    )
                }
            }
        }
        .padding()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: .constant(SettingsViewModel()))
    }
}
