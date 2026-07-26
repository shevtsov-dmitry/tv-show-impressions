pub type TvShow {
  TvShow(
    title: String,
    year: String,
    genres: Genre[],
  )

}

// title: any
// type:
//  - movie
//  - tv show
//  - anime
//  - book
// year: 2000
// expected:
//  - masterpiece
//  - philosophical message
//  - generic
//  - entertainment
//  - trash
// genres:
//   - any
//   - thing
// dropped: false
// forgettability: 8
// mood:
//   depressing: false
//   warm: false
//   hopeful: false
//   bleak: false
//   dark: false
//   cozy: false
//   existential: false
//   melancholic: false
