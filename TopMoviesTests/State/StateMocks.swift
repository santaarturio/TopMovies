//
//  StateMocks.swift
//  TopMoviesTests
//
//  Created by Macbook Pro  on 09.03.2021.
//

@testable import TopMovies

let mockMoviePreviewDTO = MoviePreviewDTO(adult: false,
                                          backdropPath: "/x0VXCWSTny5JRvpgDnw5ptwQyhA.jpg",
                                          genreIds: [878, 28, 53, 12, 27, 35],
                                          id: 346910,
                                          originalTitle: "The Predator",
                                          overview: "When a kid accidentally triggers the universe's most lethal hunters' return to Earth, only a ragtag crew of ex-soldiers and a disgruntled female scientist can prevent the end of the human race.",
                                          popularity: 144.093,
                                          posterPath: "/wMq9kQXTeQCHUZOG4fAe5cAxyUA.jpg",
                                          releaseDate: "2018-09-05",
                                          title: "The Predator",
                                          video: false,
                                          voteAverage: 5.6,
                                          voteCount: 3232)
let mockMoviePreviewDTO2 = MoviePreviewDTO(adult: false,
                                           backdropPath: "/tintsaQ0WLzZsTMkTiqtMB3rfc8.jpg",
                                           genreIds: [28, 80, 35],
                                           id: 522627,
                                           originalTitle: "The Gentlemen",
                                           overview: "American expat Mickey Pearson has built a highly profitable marijuana empire in London. When word gets out that he’s looking to cash out of the business forever it triggers plots, schemes, bribery and blackmail in an attempt to steal his domain out from under him.",
                                           popularity: 139.452,
                                           posterPath: "/jtrhTYB7xSrJxR1vusu99nvnZ1g.jpg",
                                           releaseDate: "2019-12-03",
                                           title: "The Gentlemen",
                                           video: false,
                                           voteAverage: 7.7,
                                           voteCount: 2939)
let mockUpdatedMovieDTO = MovieDTO(adult: false,
                                   backdropPath: "/x0VXCWSTny5JRvpgDnw5ptwQyhA.jpg",
                                   budget: 88000000,
                                   genres: [GenreDTO(id: 878, name: "Science Fiction")],
                                   homepage: "https://www.foxmovies.com/movies/the-predator",
                                   id: 346910,
                                   imdbID: "tt3829266",
                                   originalLanguage: "en",
                                   originalTitle: "The Predator",
                                   overview: "When a kid accidentally triggers the universe's most lethal hunters' return to Earth, only a ragtag crew of ex-soldiers and a disgruntled female scientist can prevent the end of the human race.",
                                   popularity: 148.005,
                                   posterPath: "/wMq9kQXTeQCHUZOG4fAe5cAxyUA.jpg",
                                   productionCompanies: [ProductionCompanyDTO(id: 1302,
                                                                              logoPath: "/kQZtJdyphCmq292iGDqlUx0yk2D.png",
                                                                              name: "Davis Entertainment",
                                                                              originCountry: "US")],
                                   productionCountries: [ProductionCountryDTO(name: "Canada")],
                                   releaseDate: "2018-09-05",
                                   revenue: 160542134,
                                   runtime: 107,
                                   status: "Released",
                                   tagline: "The hunt has evolved",
                                   title: "The Predator",
                                   video: false,
                                   voteAverage: 5.6,
                                   voteCount: 3256)
let mockUpdatedMovieDTO2 = MovieDTO(adult: false,
                                    backdropPath: "/tintsaQ0WLzZsTMkTiqtMB3rfc8.jpg",
                                    budget: 22000000,
                                    genres: [GenreDTO(id: 28, name: "Action")],
                                    homepage: "https://www.thegentlemen.movie/",
                                    id: 522627,
                                    imdbID: "tt8367814",
                                    originalLanguage: "en",
                                    originalTitle: "The Gentlemen",
                                    overview: "American expat Mickey Pearson has built a highly profitable marijuana empire in London. When word gets out that he’s looking to cash out of the business forever it triggers plots, schemes, bribery and blackmail in an attempt to steal his domain out from under him.",
                                    popularity: 127.931,
                                    posterPath: "/jtrhTYB7xSrJxR1vusu99nvnZ1g.jpg",
                                    productionCompanies: [ProductionCompanyDTO(id: 14,
                                                                               logoPath: "/m6AHu84oZQxvq7n1rsvMNJIAsMu.png",
                                                                               name: "Miramax",
                                                                               originCountry: "US")],
                                    productionCountries: [ProductionCountryDTO(name: "United Kingdom")],
                                    releaseDate: "2019-12-03",
                                    revenue: 114996853,
                                    runtime: 113,
                                    status: "Released",
                                    tagline: "Criminal. Class.",
                                    title: "The Gentlemen",
                                    video: false,
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
