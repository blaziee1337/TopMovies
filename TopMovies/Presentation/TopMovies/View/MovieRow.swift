//
//  MovieRow.swift
//  TopMovies
//
//  Created by Halil Yavuz on 03.12.2024.
//

import SwiftUI

struct MovieRow: View {
    let movie: Movie
    @ObservedObject var viewModel: TopMoviesViewModel
    @State private var posterImage: UIImage? = nil
    @State private var editedDescription: String
    @State private var showEditingSheet: Bool = false

    init(movie: Movie, viewModel: TopMoviesViewModel) {
        self.movie = movie
        self.viewModel = viewModel
        _editedDescription = State(initialValue: movie.shortDescription ?? "")
    }

    var body: some View {
        HStack(spacing: 16) {
            if let posterImage = posterImage {
                Image(uiImage: posterImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 120)
                    .cornerRadius(8)
            } else {
                ProgressView()
                    .frame(width: 80, height: 120)
                    .onAppear {
                        Task {
                            await loadImage()
                        }
                    }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(movie.name)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.primary)
                
                HStack(spacing: 3) {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                    Text("\(String(format: "%.1f", movie.rating.imdb)),")
                        .font(.system(size: 14))
                    Text("\(movie.year),")
                        .font(.system(size: 14))
                    
                    if let movieLength = movie.movieLength {
                        let hours = movieLength / 60
                        let minutes = movieLength % 60
                        Text("\(hours) ч \(minutes) мин")
                            .font(.system(size: 14))
                    } else {
                        Text("")
                    }
                }
                
                HStack(spacing: 3) {
                    Text("\(movie.countries.first?.name ?? ""),")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                    Text("\(movie.genres.first?.name ?? "")")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }

                HStack {
                    Text(editedDescription)
                        .font(.system(size: 14))
                    Button(action: {
                        showEditingSheet = true
                    }) {
                        Image(systemName: "pencil.circle.fill")
                            .foregroundColor(.blue)
                    }
                }
            }
        }
        .sheet(isPresented: $showEditingSheet) {
            MovieDescriptionEditView(description: $editedDescription, onSave: {
                if let movieToUpdate = viewModel.movies.first(where: { $0.id == movie.id }) {
                    viewModel.updateMovieDescription(movieToUpdate, newDescription: editedDescription)
                }
                showEditingSheet = false
            })
        }
    }
    
    private func loadImage() async {
        guard let url = URL(string: movie.poster.url) else { return }
        
        if let cachedImage = viewModel.imagecacheManager.getImage(forKey: movie.poster.url) {
            self.posterImage = cachedImage
        } else {
            do {
                let image = try await viewModel.imagecacheManager.loadImage(from: url)
                self.posterImage = image
            } catch {
                print("Ошибка загрузки изображения: \(error)")
            }
        }
    }
}
