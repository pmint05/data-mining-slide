#import "../utils.typ": *

= Biểu diễn dữ liệu

== Vector

#figure(
  image("../images/vector-1.png", width: 100%),
  caption: [Một ví dụ từ Pinecone],
)
#pagebreak()

#align(center)[
  #box(
    stroke: 1.2pt,
    inset: 15pt,
    upper(text(15pt, weight: "bold", "Kiểu biểu diễn phổ biến nhất")),
  )
  #v(20pt)
]


- Các mô hình học máy dựa trên nền tảng của đại số:

#grid(
  columns: 2,
  align(left)[
    #figure(
      image("../images/dm02.png", width: 80%),
      caption: "Đạo hàm",
    )
  ],
  align(left)[
    #figure(
      image("../images/dm04.png", width: 93%),
      caption: "Nhân ma trận",
    )
  ],
)

#pagebreak()

- Có thể đo khoảng cách một cách nhanh chóng và dễ dàng

#figure(
  image("../images/dm05.png", width: 70%),
  caption: "Khoảng cách vector trong không gian",
)

#pagebreak()

- Dễ cải tiến tốc độ sử dụng GPU
- Tạo ra không gian vector liên tục giúp mô hình có thể tự hiểu ngữ nghĩa

  #figure(
    image("../images/dm06.png", width: 80%),
    caption: "Không gian các từ",
  )


== Hashing
