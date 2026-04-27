// 1. Internal Imports
#import "article.typ": article
#import "paper.typ": paper, framed
#import "shared.typ": *

// Export specific color aliases
#let accent = lab-colors.accent
#let primary = lab-colors.primary

// Also export the full dictionary just in case
#let colors = lab-colors


#let parse-file-metadata(filename) = {
  // Remove extension
  let base = filename.trim(".typ")

  // Split at the time-title separator
  let parts = base.split("--")
  let stamp = parts.at(0)
  let rest = parts.at(1, default: "untitled__none")

  // Split at the title-tags separator
  let content = rest.split("__")
  let raw-title = content.at(0)
  let raw-tags = content.at(1, default: "")

  (
    date: stamp.slice(0, 8),
    time: (
      hr: stamp.slice(9, 11),
      min: stamp.slice(11, 13),
      sec: stamp.slice(13, 15)
    ),
    title: raw-title.replace("-", " "),
    tags: raw-tags.split("_")
  )
}
