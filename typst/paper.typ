#import "shared.typ": *

#let framed(title: none, body) = {
    block(
        width: 100%,
        inset: (y: 0.8em),
        breakable: false,
        spacing: 0pt,
        above: 6pt,
        below: 6pt
    )[
        #line(length: 85%, stroke: 0.5pt + luma(200))
        #set align(left)
        #set text(size: 9pt)
        #if title != none [*#title* \ #v(0.2em)]
        #body
        #line(length: 100%, stroke: 0.5pt + luma(200))
    ]
}

#let appendix(body) = {
    // Reset counters for images, tables, AND code blocks (raw)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)

    // Set numbering to A.1 for all figures
    set figure(numbering: "A.1")

    set text(size: 9pt)
    set par(spacing: 1em)

    align(left)[
        #block(spacing: 1em, width: 80%)[
            #body
            #v(1em)
        ]
    ]
}

#let paper(title: none, author: none, body) = {
    // Font & General Text settings
    set text(font: body-font, size: 11pt)
    set par(first-line-indent: 1.5em, spacing: 0.85em, justify: true)

    // Code blocks and Quote specific behavior
    set raw(theme: "oberon.tmTheme")
    show raw.where(block: true): it => academic-code(it)

    // Academic Headings
    show heading: set align(center)
    show heading: set text(size: 20pt, weight: "regular")
    show heading: smallcaps
    set heading(numbering: "I.I.I.")

    // Figure formatting
    set figure(numbering: "I", supplement: [Figure])
    show figure: set block(above: 12pt)

    show figure.caption: it => {
        set text(size: 9pt)
        v(6pt)
        block(width: 80%)[
            #set align(center)
            #it
        ]
        v(1em)
    }


    // Quotes
    show quote: it => {
        set block(
            width: 80%,
            inset: (left: 12pt, top: 10pt, bottom: 10pt),
            stroke: (right: 2pt + lab-colors.accent),
            fill: white,
        )
        show raw: set text(size: 10pt, weight: "light")
        show raw: set block(clip: true)
        set raw(wrap: false)
        it
    }

    // Bulleted Lists (Unordered)
    set list(indent: 1em, body-indent: 1em)
    show list: set block(above: 1em, below: 1em)

    // Enums
    set enum(indent: 1em, body-indent: 1em)
    show enum: set block(above: 1em, below: 1em)

    // Header and Page numbering
    set page(
        numbering: "— 1 —",
        header: context {
            if counter(page).get().first() > 1 [
                #set text(size: 9pt, style: "italic")
                #title
                #h(1fr)
                #author
            ]
        }
    )

    // Style level 1 headings
    show heading.where(level: 1): it => {
        set text(size: 18pt)
        block(above: 1em, below: 1em)[
            #it
        ]
    }

    show heading.where(level: 2): it => {
        set text(size: 14pt)
        block(above: 1em, below: 1em)[
            #it
        ]
    }


    // Title rendering
    if title != none {
        align(center)[
            #text(size: 22pt)[#title]
            #v(2em)
        ]
    }

    body
}
