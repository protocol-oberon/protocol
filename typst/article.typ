#import "shared.typ": *

#let article(
  title: none,
  subtitle: none,
  date: "2026-04-27",
  body
) = {
  assert(
    date.match(regex("^\d{4}-\d{2}-\d{2}$")) != none,
    message: "Protocol Error: Date must be in YYYY-MM-DD format. Found: " + date
  )

  set page(
    margin: (x: 1.25in, y: 1in),
    numbering: "1",
  )

  set text(
    font: mono-font,
    size: 9pt,
    fill: lab-colors.primary
  )

  set par(
    justify: true,
    spacing: 1.75em,
  )

  show raw.where(block: true): it => protocol-code(it)

  // Level 1: Underline matches text length exactly
  show heading.where(level: 1): it => {
    set text(size: 14pt, fill: lab-colors.accent)
    block(above: 2.5em, below: 1.2em)[
      #block(inset: (bottom: 0.3em), stroke: (bottom: protocol-stroke))[
        #it
      ]
    ]
  }

  show heading.where(level: 2): it => {
    set text(size: 11pt, fill: lab-colors.accent)
    block(above: 1.5em, below: 1em)[#it]
  }

  // Header/Title Block: Line matches title length exactly
  if title != none {
    // Outer block handles the 3em spacing to the body text
    block(width: 100%, below: 3em)[
      #stack(dir: ttb, spacing: 0.4em)[
        // The title and its underline
        #box(inset: (bottom: 0.3em), stroke: (bottom: protocol-stroke))[
          #text(18pt, weight: "bold", fill: lab-colors.accent)[#title]
        ]

        // Subtitle (if exists)
        #if subtitle != none {
          text(11pt, style: "italic")[#subtitle]
        }

        // Date
        #text(8pt, fill: lab-colors.primary.lighten(20%))[#date]
      ]
    ]
  }

  body
}
