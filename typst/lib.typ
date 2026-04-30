// 1. Internal Imports
#import "article.typ": article
#import "paper.typ": paper, framed, appendix
#import "shared.typ": *

// Export specific color aliases
#let accent = lab-colors.accent
#let primary = lab-colors.primary

// Also export the full dictionary just in case
#let colors = lab-colors


#let parse-file-metadata(filename) = {
  let base = filename.trim(".typ")
  let parts = base.split("--")
  let stamp = parts.at(0)

  // Extract date components
  let year  = stamp.slice(0, 4)
  let month = stamp.slice(4, 6)
  let day   = stamp.slice(6, 8)
  let formatted-date = year + "-" + month + "-" + day

  let rest = parts.at(1, default: "untitled__none")
  let content = rest.split("__")

  (
    date: formatted-date, // Now 2026-04-27
    raw-date: stamp.slice(0, 8),
    time: (
      hr: stamp.slice(9, 11),
      min: stamp.slice(11, 13),
      sec: stamp.slice(13, 15)
    ),
    title: content.at(0).replace("-", " "),
    tags: content.at(1, default: "").split("_")
  )
}
