== Hierarchical Navigable Small World
#align(top)[
  === Định nghĩa
]
#align(center)[
  #box(
    stroke: 1.2pt,
    inset: 15pt,
    upper(text(15pt, weight: "bold", "Efficient and robust approximate nearest neighbor search using Hierarchical Navigable Small World graphs")),
  )
  #v(20pt)
]
- Phân phối các cạnh vào các tầng có độ dày và độ dài khác nhau
#figure(
  image("/images/hnswg_1.png", width: 80%),
  caption: "Minh họa HNSWG"
)
#pagebreak()

#align(top)[
  === Tìm kiếm trong HNSWG:
]

- Bắt đầu từ tầng trên cùng
- Tìm kiếm (các) node gần nhất với node đang tìm
- Hạ xuống tầng tiếp theo và tiếp tục tìm kiếm với các nodes vừa thu được
- Lặp lại quá trình này đến tầng dưới cùng

#figure(
  image("/images/hnswg_2.png", width: 80%),
  caption: "Tìm kiếm trên HNSWG"
)

#figure(
  image("../images/hnsw_search2.png", width: 40%),
  caption: "Tìm kiếm trên HNSWG"
)

#pagebreak()

#align(top)[
  === Thêm đỉnh
]

- Xây dựng tăng dần (incremental)
- Phân bố đỉnh theo xác suất giảm theo cấp số mũ
#figure(
  image("../images/hnswg_distribution.png", width: 80%),
  caption: "Phân phối tập đỉnh của HNSWG"
)

#pagebreak()
- Giả sử đỉnh $u$ cần được chèn vào các tầng từ $0$ đến $L$: tại mỗi tầng, $u$ được kết nối với các nút gần nó nhất.
#figure(
  image("/images/hnswg_3.png", width: 70%),
  caption: "Chèn node mới trong HNSWG"
)

#pagebreak()

#align(top)[
  === Xóa node (Deletion)
]

- Phiên bản HNSWG trong bài báo gốc không hỗ trợ xóa thực sự (true deletion)
- Xóa giả: cắm cờ _"đã xóa"_
- Xóa thật
