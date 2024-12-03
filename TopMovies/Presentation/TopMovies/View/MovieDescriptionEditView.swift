//
//  MovieDescriptionEditView.swift
//  TopMovies
//
//  Created by Halil Yavuz on 03.12.2024.
//

import SwiftUI

struct MovieDescriptionEditView: View {
    @Binding var description: String
    var onSave: () -> Void
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("Редактировать описание")
                .font(.headline)
                .padding()
            
            TextEditor(text: $description)
                .border(Color.gray, width: 1)
                .padding()
            
            HStack {
                Button("Сохранить") {
                    onSave()
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(8)
                
                Button("Отмена") {
                    dismiss()
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.gray)
                .cornerRadius(8)
            }
        }
        .padding()
    }
}
