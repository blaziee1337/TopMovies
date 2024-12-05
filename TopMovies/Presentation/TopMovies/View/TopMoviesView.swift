//
//  TopMoviesView.swift
//  TopMovies
//
//  Created by Halil Yavuz on 01.12.2024.
//

import SwiftUI

struct TopMoviesView: View {
    @ObservedObject var viewModel: TopMoviesViewModel
    @State var showAlert: Bool = false
    @State private var movieToDelete: Movie?
    
    var body: some View {
        List {
            ForEach(viewModel.movies) { movie in
                MovieRow(movie: movie, viewModel: viewModel)
                    .listRowSeparatorTint(Color(UIColor.lightGray))
                    .contextMenu {
                        Button("Удалить", role: .destructive) {
                            movieToDelete = movie
                            showAlert = true
                        }
                    }
                    .alert("Удалить фильм?", isPresented: $showAlert) {
                        Button("Удалить", role: .destructive) {
                            
                            if let movieToDelete = movieToDelete {
                                viewModel.deleteMovie(movieToDelete)
                                
                            }
                        }
                        Button("Отмена", role: .cancel) { }
                    } message: {
                        if let movieToDelete = movieToDelete {
                            Text("Вы действительно хотите удалить фильм \(movieToDelete.name)?")
                        }
                    }
                
                    .onAppear {
                        if movie == viewModel.movies.last!, !viewModel.isLoading {
                            Task {
                                await viewModel.fetchTopMovies()
                            }
                        }
                    }
            }
            
            if viewModel.isLoading {
                ProgressView("Загрузка...")
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .listStyle(.plain)
        .onAppear {
            Task {
                await viewModel.fetchTopMovies()
            }
        }
        .overlay(alignment: .top) {
                Color.black
                    .ignoresSafeArea(edges: .top)
                    .frame(height: 0)
            }
    }
}
