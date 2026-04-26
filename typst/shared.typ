#let lab-colors = (
  primary: rgb("#000000"), // Bold Black
  accent:  rgb("#7030A0"), // Deep Royal Purple
  surface: rgb("#FFFFFF"),
)

#let protocol-stroke = 1.5pt + lab-colors.primary
#let academic-stroke = 0.5pt + luma(200)

// Using the exact family names from the binary packages
#let body-font = "Cormorant Garamond"
#let mono-font = "IosevkaTerm NF"


// Lab Protocol Style: Heavy lines, no background, tight spacing
#let protocol-code(it) = {
  set text(font: mono-font, size: 8pt)
  stack(
    spacing: 1.2em,
    line(length: 100%, stroke: 1pt + lab-colors.primary),
    pad(x: 0.5em, it),
    line(length: 100%, stroke: 1pt + lab-colors.primary),
  )
}

// Academic Style: Lighter refined lines
#let academic-code(it) = {
  set text(font: mono-font, size: 8pt)
  stack(
    spacing: 1.5em,
    line(length: 100%, stroke: academic-stroke),
    pad(x: 0.5em, it),
    line(length: 100%, stroke: academic-stroke),
  )
}
