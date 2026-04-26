#import "shared.typ": *

#let framed(title: none, body) = {
  block(
    width: 100%,
    inset: (y: 0.8em),
    breakable: false,
    spacing: 0pt,
    above: 0pt,
    below: 0pt
  )[
    #line(length: 100%, stroke: 0.5pt + luma(200))
    #set align(center)
    #set text(size: 10pt)
    #if title != none [*#title* \ #v(0.2em)]
    #body
    #line(length: 100%, stroke: 0.5pt + luma(200))
  ]
}


#let paper(title: none, body) = {
  // Font & General Text settings
  set text(font: body-font, size: 11pt)
  set par(first-line-indent: 1.5em, spacing: 0.85em, justify: true)

  // Academic Headings
  show heading: set align(center)
  show heading: set text(size: 20pt, weight: "regular")
  show heading: smallcaps
  set heading(numbering: "I.I.I.")

  // Figure formatting (Original Logic)
  set figure(gap: 0.5em)
  set figure.caption(position: top)
  show figure: set block(above: 1.5em, below: 1.5em)
  show figure.caption: it => context {
    block(width: 85%, below: 0pt, inset: (bottom: 0pt))[
      #set align(center)
      *#it.supplement #it.counter.display()* #it.separator #it.body
    ]
  }

  // Code blocks (Original Logic with IosevkaTerm NF)
  let code-stroke = 0.5pt + luma(200)
  show raw.where(block: true): it => academic-code(it)

  // Header and Page numbering
  set page(
    numbering: "— 1 —",
    header: context {
      if counter(page).get().first() > 1 [
        Modal _μ Calculus for Intracellular Computation — PhD Proposal_
        #h(1fr)
        _Shiloh Alleyne BSC, MSC_
      ]
    }
  )

  // Title rendering
  if title != none {
    align(center)[
      #text(size: 22pt)[#title]
      #v(2em)
    ]
  }

  body
}
