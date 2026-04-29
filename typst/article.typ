#import "shared.typ": *

#let article(
    title: none,
    subtitle: none,
    author: none,
    tags: (),
    date: "2026-04-28",
    body
) = {
    // Check if date string is valid
    assert(
        date.match(regex("^\d{4}-\d{2}-\d{2}$")) != none,
        message: "Protocol Error: Date must be in YYYY-MM-DD format. Found: " + date
    )

    // Set file metadata
    set document(title: title, author: author)

    // Set page dimensions and margins
    set page(
        width: 800pt,
        margin: (
            x: 120pt,
            y: 2cm
        ),
        height: auto,
    )

    // Set default body text style
    set text(
        font: mono-font,
        size: 12pt,
        fill: lab-colors.primary
    )

    // Set paragraph alignment and spacing
    set par(
        justify: true,
        leading: 0.8em,  // Space between lines in a paragraph
        spacing: 2.5em   // Space between paragraphs
    )

    // Ensure all blocks (lists, code, figures) have consistent vertical margins
    set block(spacing: 2.5em)

    // Set syntax highlighting theme
    set raw(theme: "oberon.tmTheme")

    // Style web links
    show link: set text(fill: lab-colors.accent)
    show link: it => {
        underline(stroke: 0.5pt + lab-colors.accent, offset: 2pt)[#it]
    }

    // Style code blocks with left accent border
    show raw: set block(
        width: 100%,
        inset: (left: 12pt, top: 10pt, bottom: 10pt),
        stroke: (left: 2pt + lab-colors.accent),
        fill: white,
    )

    // Style Quote
    show quote: set block(
        width: 80%,
        inset: (left: 12pt, top: 10pt, bottom: 10pt),
        stroke: (right: 2pt + lab-colors.accent),
        fill: white,
    )

    show quote: it => {
        show raw: set text(
            size: 10pt,
            weight: "light"
        )
    }

    // Set font for math
    show math.equation: set text(font: "IosevkaTerm NF Light Obl")

    // Set font for code snippets
    show raw: set text(font: "IosevkaTerm NF")
    show raw.where(block: true): set text(size: 11pt)
    show raw.where(block: false): set text(size: 1em)

    // Inline code styling: Accent background with surface foreground
    show raw.where(block: false): it => {
        box(
            fill: lab-colors.accent,
            inset: (left: 4pt, x: 4pt, y: 0pt),
            outset: (y: 3pt),
        )[
            #set text(fill: lab-colors.surface)
            #it
        ]
    }

    // Style figures with an accent top-bar on the caption only
    show figure: it => {
        block(width: 100%, inset: (y: 1.5em))[
            #grid(
                columns: (1fr, 200pt),
                column-gutter: 24pt,
                // Column 1: Image
                it.body,
                // Column 2: Caption with top bar
                stack(dir: ttb)[
                    #line(length: 100%, stroke: 2pt + lab-colors.accent)
                    #v(0.6em)
                    #set text(size: 10pt, fill: lab-colors.primary.lighten(20%))
                    #it.caption
                ]
            )
        ]
    }

    // Style bullet points (square, 10pt, and indented)
    set list(
        marker: box(
            fill: lab-colors.primary,
            width: 0.5em,
            height: 0.5em,
            baseline: 0.1em,
        ),
        indent: 1.5em,
        body-indent: 0.8em,
    )

    // Set list text size to 10pt
    show list: it => {
        set text(size: 11pt)
        block(width: 80%)[#it]
    }

    // Style level 1 headings with underline
    show heading.where(level: 1): it => {
        set text(size: 18pt, fill: lab-colors.accent)
        block(above: 2.5em, below: 1.2em)[
            #block(inset: (bottom: 0.3em), stroke: (bottom: protocol-stroke))[
                #it
            ]
        ]
    }

    // Style level 2 headings
    show heading.where(level: 2): it => {
        set text(size: 14pt, fill: lab-colors.accent)
        block(above: 2em, below: 1.2em)[#it]
    }

    // Create the title and metadata header
    if title != none {
        block(width: 100%, below: 3em)[
            // Keep the local override so things stay tight by default
            // #set par(spacing: 0.8em)
            // #set block(spacing: 0.8em)

            #grid(
                columns: 100%,
                row-gutter: 0.4em, // Tight gutter for Subtitle/Author

                // 1. Title Box
                block(
                    width: 100%,
                    inset: (left: 15pt, top: 5pt, bottom: 5pt),
                    stroke: (left: 4pt + lab-colors.primary),
                    below: 1.2em, // Space between Title and Subtitle
                )[
                    #set align(left)
                    #set text(26pt, fill: lab-colors.primary, hyphenate: false)
                    #set par(leading: 0.3em, justify: false)
                    #title
                ],

                // 2. Subtitle
                if subtitle != none {
                    text(14pt, style: "italic")[#subtitle]
                },

                // 3. Author
                if author != none {
                    text(12pt, weight: "medium")[By #author]
                },

                // 4. Metadata (With a manual gap above it)
                {
                    v(1.5em) // This creates the "regular gap" you want
                    set text(10pt)
                    text(fill: lab-colors.primary.lighten(20%))[#date]
                    if tags.len() > 0 {
                        h(0.8em)
                        text(fill: lab-colors.accent)[•]
                        h(0.8em)
                        text(fill: lab-colors.primary.lighten(40%))[#tags.join(" / ")]
                    }
                }
            )
        ]
    }

    // Render the actual content
    body

    v(25em)
}
