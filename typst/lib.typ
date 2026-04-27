// 1. Internal Imports
#import "article.typ": article
#import "paper.typ": paper, framed
#import "shared.typ": *

// Export specific color aliases
#let accent = lab-colors.accent
#let primary = lab-colors.primary

// Also export the full dictionary just in case
#let colors = lab-colors


#let parse-file-metadata(path) = {
  // path format: 20260427T091208--title__slug.typ
  let filename = str(path).split("/").last()
  let parts = filename.split("--")

  let timestamp = parts.at(0, default: "00000000T000000")
  let content = parts.at(1, default: "unknown")

  // Split title and tags/slug at the double underscore
  let title-parts = content.split("__")
  let raw-title = title-parts.at(0).replace("-", " ")

  (
    id: timestamp,
    title: raw-title,
  )
}
