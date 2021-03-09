//
//  StateMocks.swift
//  TopMoviesTests
//
//  Created by Macbook Pro  on 09.03.2021.
//

@testable import TopMovies

public let mockMovieDTO = MovieDTO(adult: false,
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
public let mockMovieDTO2 = MovieDTO(adult: false,
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

public let mockCategoryDTO = CategoryDTO(name: "Popular",
                                         page: 9,
                                         results: [mockMovieDTO],
                                         totalPages: 500,
                                         totalResults: 10000)
public let mockCategoryDTO2 = CategoryDTO(name: "Top Rated",
                                         page: 10,
                                         results: [mockMovieDTO2],
                                         totalPages: 500,
                                         totalResults: 10000)

public let mockMovie = Movie(dto: mockMovieDTO)
public let mockMovie2 = Movie(dto: mockMovieDTO2)

public let mockMovieCategory = MovieCategory(dto: mockCategoryDTO)
public let mockMovieCategory2 = MovieCategory(dto: mockCategoryDTO2)

public struct MockError: Error {
  let description: String
}
