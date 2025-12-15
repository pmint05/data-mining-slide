#import "../utils.typ": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

= Ứng dụng thực tế

== Hệ thống đề xuất

#figure(
  [
    #rimg("/images/youtube-recommended.png", 95%) #v(-0pt)],
  caption: [Hệ thống đề xuất trên YouTube],
)
#figure(
  [#image("/images/recommendation-types.svg", width: 80%) #v(20pt)],
  caption: [Các loại hệ thống đề xuất],
)
== Nhận diện trùng lặp văn bản
#figure(
  [#rimg("/images/turnitin.png", 85%) #v(0pt)],
  caption: [Giao diện phần mềm Turnitin],
)

#figure(
  diagram(
    node-stroke: .1em,
    spacing: (4em, 2em),
    node-inset: 10pt,
    node((0, 2), [Textual\ similarity]),
    edge((0, 2), (1, 1), "-|>"),
    edge((0, 2), (1, 2), "-|>"),
    edge((0, 2), (1, 3), "-|>"),
    node((1, 1), [Lexical \ similarity]),
    node((1, 2), [Structure/syntactic\ similarity]),
    node((1, 3), [Sematic\ similarity]),
  ),
  caption: [Các loại tương đồng văn bản],
)


== Tìm hình ảnh giống nhau
#figure(
  [#rimg("/images/google-lens.png", 86%) #v(0pt)],
  caption: [Tìm kiếm hình ảnh tương tự sử dụng Google Lens],
)