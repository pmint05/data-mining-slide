#import "@preview/lovelace:0.3.0": *
#import "@preview/touying:0.5.3": *
#import "stargazer.typ": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#import "@preview/numbly:0.1.0": numbly

#show: stargazer-theme.with(
  aspect-ratio: "16-9",
  config-info(),
)
#set text(font: "New Computer Modern", lang: "vi")
#set heading(numbering: numbly("{1}.", default: "1.1."))
#set par(justify: true)
#show figure.caption: set text(17pt)

#let authors = (
  (name: "Hoàng Hữu Đức", id: "23020046"),
  (name: "Lê Minh Tuấn", id: "23020149"),
  (name: "Phạm Minh Thông", id: "23020164"),
  (name: "Bùi An Huy", id: "23020079"),
  (name: "Lê Minh Đạt", id: "23020037"),
)
#slide(navigation: none, progress-bar: false, self => [
  #align(center, text(20pt, strong("Nhóm 5 - Chủ đề 4")))
  #align(center)[
    #text(28pt, upper(strong("Finding similar items")))
    #v(-16pt)
    #text(28pt, [
      #set par(leading: 1em)
      Tìm kiếm tương tự
    ])
  ]
  #align(center, text(18pt, [
    Thành viên nhóm:
  ]))
  #align(center)[
    #set par(leading: 2em)
    #grid(
      inset: 5pt,
      columns: 2,
      ..authors
        .map(author => (
          [
            #align(left)[
              #text(17pt, strong(author.name))
            ]
          ],
          [
            #align(right)[
              #h(10pt)
              #text(17pt, (author.id))
            ]
          ],
        ))
        .flatten(),
    )
  ]
])

#outline-slide(title: "Mục lục")


#include "src/intro.typ"
#include "src/real_application.typ"
#include "src/representation.typ"
#include "src/minhash.typ"
#include "src/measures.typ"
#include "src/find_pairs.typ"
#include "./src/knng.typ"
#include "/src/swg.typ"
#include "/src/hnswg.typ"
#include "src/product_quantization.typ"
