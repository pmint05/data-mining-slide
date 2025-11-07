#import "@preview/lovelace:0.3.0": *
#import "@preview/touying:0.5.3": *
#import "stargazer.typ": *
#import "@preview/fletcher:0.5.3" as fletcher: diagram, edge, node

#import "@preview/numbly:0.1.0": numbly

#show: stargazer-theme.with(
  aspect-ratio: "16-9",
  config-info(
    // subtitle: [vehicle routing problem with time windows],
    // author: [Huỳnh Tiến Dũng],
    // instructor: [TS. Hoàng Thị Điệp],
    // date: "17/12/2024",
    // institution: [Trường Đại học Công Nghệ - ĐHQGHN],
  ),
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

= Ứng dụng thực tế

== Hệ thống đề xuất
== Nhận diện trùng lặp văn bản
== Tìm hình ảnh giống nhau

= Biểu diễn dữ liệu

= Định nghĩa tương đồng

== Tương đồng là gì?
Trong data mining, "độ tương đồng" được hiểu là độ đo mức độ giống nhau giữa hai đối tượng dữ liệu hay mức độ chồng lặp khi biểu diễn chúng dưới dạng tập hợp hoặc vector đặc trưng.

== Các đối tượng như thế nào thì được coi là tương đồng?
Hai đối tượng được coi là tương đồng khi chúng chia sẻ nhiều đặc trung chung nhau, tức là có mức độ trùng lặp cao giữa các biểu diễn của chúng.


= Các phép đo độ tương đồng

== Jaccard Similarity

== Phép đo khoảng cách

=== $L_p$ norm
=== Jaccard Distance
=== Cosine Similarity
=== Edit Distance
=== Hamming Distance

== So sánh