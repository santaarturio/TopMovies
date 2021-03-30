//
//  StateMocks.swift
//  TopMoviesTests
//
//  Created by Macbook Pro  on 09.03.2021.
//

@testable import TopMovies

let mockMoviePreviewDTO = MoviePreviewDTO(adult: false,
                                          backdropPath: "/x0VXCWSTny5JRvpgDnw5ptwQyhA.jpg",
                                          id: 346910,
                                          overview: "When a kid accidentally triggers the universe's most lethal hunters' return to Earth, only a ragtag crew of ex-soldiers and a disgruntled female scientist can prevent the end of the human race.",
                                          posterPath: "/wMq9kQXTeQCHUZOG4fAe5cAxyUA.jpg",
                                          releaseDate: "2018-09-05",
                                          title: "The Predator",
                                          voteAverage: 5.6,
                                          voteCount: 3232)
let mockMoviePreviewDTO2 = MoviePreviewDTO(adult: false,
                                           backdropPath: "/tintsaQ0WLzZsTMkTiqtMB3rfc8.jpg",
                                           id: 522627,
                                           overview: "American expat Mickey Pearson has built a highly profitable marijuana empire in London. When word gets out that he’s looking to cash out of the business forever it triggers plots, schemes, bribery and blackmail in an attempt to steal his domain out from under him.",
                                           posterPath: "/jtrhTYB7xSrJxR1vusu99nvnZ1g.jpg",
                                           releaseDate: "2019-12-03",
                                           title: "The Gentlemen",
                                           voteAverage: 7.7,
                                           voteCount: 2939)
let mockUpdatedMovieDTO = MovieDTO(adult: false,
                                   backdropPath: "/x0VXCWSTny5JRvpgDnw5ptwQyhA.jpg",
                                   budget: 88000000,
                                   genres: [GenreDTO(name: "Science Fiction")],
                                   id: 346910,
                                   overview: "When a kid accidentally triggers the universe's most lethal hunters' return to Earth, only a ragtag crew of ex-soldiers and a disgruntled female scientist can prevent the end of the human race.",
                                   posterPath: "/wMq9kQXTeQCHUZOG4fAe5cAxyUA.jpg",
                                   productionCompanies: [ProductionCompanyDTO(logoPath: "/kQZtJdyphCmq292iGDqlUx0yk2D.png",
                                                                              name: "Davis Entertainment",
                                                                              originCountry: "US")],
                                   releaseDate: "2018-09-05",
                                   runtime: 107,
                                   tagline: "The hunt has evolved",
                                   status: "Released",
                                   title: "The Predator",
                                   voteAverage: 5.6,
                                   voteCount: 3256)
let mockUpdatedMovieDTO2 = MovieDTO(adult: false,
                                    backdropPath: "/tintsaQ0WLzZsTMkTiqtMB3rfc8.jpg",
                                    budget: 22000000,
                                    genres: [GenreDTO(name: "Action")],
                                    id: 522627,
                                    overview: "American expat Mickey Pearson has built a highly profitable marijuana empire in London. When word gets out that he’s looking to cash out of the business forever it triggers plots, schemes, bribery and blackmail in an attempt to steal his domain out from under him.",
                                    posterPath: "/jtrhTYB7xSrJxR1vusu99nvnZ1g.jpg",
                                    productionCompanies: [ProductionCompanyDTO(logoPath: "/m6AHu84oZQxvq7n1rsvMNJIAsMu.png",
                                                                               name: "Miramax",
                                                                               originCountry: "US")],
                                    releaseDate: "2019-12-03",
                                    runtime: 113,
                                    tagline: "Criminal. Class.",
                                    status: "Released",
                                    title: "The Gentlemen",
                                    voteAverage: 7.7,
                                    voteCount: 3028)

let mockCategoryDTO = CategoryDTO(name: "Popular",
                                  page: 9,
                                  results: [mockMoviePreviewDTO],
                                  totalPages: 500,
                                  totalResults: 10000)
let mockCategoryDTO2 = CategoryDTO(name: "Top Rated",
                                   page: 10,
                                   results: [mockMoviePreviewDTO2],
                                   totalPages: 500,
                                   totalResults: 10000)

let mockMoviePreview = MoviePreview(dto: mockMoviePreviewDTO)
let mockMoviePreview2 = MoviePreview(dto: mockMoviePreviewDTO2)

let mockUpdatedMovie = Movie(dto: mockUpdatedMovieDTO)
let mockUpdatedMovie2 = Movie(dto: mockUpdatedMovieDTO2)

let mockMovieCategory = MovieCategory(dto: mockCategoryDTO)
let mockMovieCategory2 = MovieCategory(dto: mockCategoryDTO2)

struct MockError: Error {
  let description: String
}
