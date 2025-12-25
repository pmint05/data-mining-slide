#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "@preview/lovelace:0.3.0": *

== K-Nearest-Neighbor Graph

#align(top)[
  === Định nghĩa
]

- Mỗi đỉnh có cạnh nối tới $k$ đỉnh gần nhất

#figure(
  image("../images/dm14.png", width: 40%),
  caption: "Ví dụ đồ thị có k = 3, khoảng cách Euclid",
)

#pagebreak()

#align(top)[
  === Xây dựng
]

- Brute-force: Tính khoảng cách giữa mọi cặp đỉnh
- Độ phức tạp: $cal(O)(n^2 d)$

#pagebreak()

#align(center)[
  #box(
    stroke: 1.2pt,
    inset: 15pt,
    upper(text(15pt, weight: "bold", "Efficient K-Nearest Neighbor Graph Construction for Generic Similarity Measures")),
  )
  #v(20pt)
]
- Hàng xóm của hàng xóm khả năng cao cũng là hàng xóm
- Bắt đầu với đồ thị ngẫu nhiên, cải thiện dần

#figure(
  image("../images/nndescent-idea.png", width: 50%),
  caption: "Ý tưởng của NNDescent",
)


#pagebreak()

#box(
  height: 355pt,
  grid(
    columns: (60%, auto),
    gutter: 20pt,
    [
      #[
        #set text(size: 15pt)
        #figure(
          kind: "algorithm",
          supplement: [Thuật toán],

          pseudocode-list(
            hooks: .5em,
            booktabs: true,
            numbered-title: [Xây dựng KNNG với NNDescent #h(100%)],
          )[
            + *function* NNDescent*(*$V$*)*
              + *for* $u$ *in* $V$ *do*
                + randomly pick $k$ other nodes
              + *while* number of updates < threshold *do*
                + *for* $u$ *in* $V$ *do*
                  + *for* $v$ *in* neighbors($u$) *do*
                  + *for* $v'$ *in* neighbors($v$) *do*
                    + compute $d(u, v')$
                  + pick out $k$ closest nodes to $u$, update $u$'s neighbor list
          ],
        )
      ]
    ],
    [
      #set text(size: 16pt)
      Độ phức tạp thuật toán là $cal(O)(m n k^2 d)$\
      -- $m$ lần lặp\
      -- Mỗi lần duyệt mất $n k^2$\
      -- Tính khoảng cách mất $d$

      Ưu điểm:\
      -- Hoạt động với mọi hàm khoảng cách\
      -- Sử dụng thêm ít bộ nhớ\
      -- Độ chính xác cao\
      -- Dễ cài đặt
    ],
  ),
)

#pagebreak()

#figure(
  image("../images/nndescent1.png", width: 50%),
  caption: "Tập đỉnh cần tạo đồ thị",
)

#figure(
  image("../images/nndescent2.png", width: 50%),
  caption: "Đồ thị ban đầu được khởi tạo ngẫu nhiên",
)

#figure(
  image("../images/nndescent3.png", width: 50%),
  caption: "Cải thiện hàng xóm đỉnh 1",
)

#figure(
  image("../images/nndescent4.png", width: 50%),
  caption: "Cải thiện hàng xóm đỉnh 2",
)

#figure(
  image("../images/nndescent5.png", width: 50%),
  caption: "Cải thiện hàng xóm đỉnh 3",
)

#figure(
  image("../images/nndescent6.png", width: 50%),
  caption: "Cải thiện hàng xóm đỉnh 4",
)

#figure(
  image("../images/nndescent7.png", width: 50%),
  caption: "Cải thiện hàng xóm đỉnh 5",
)

#figure(
  image("../images/nndescent8.png", width: 50%),
  caption: "Không còn cải thiện thêm được nữa",
)


#align(top)[
  === Truy vấn
]

- Heuristic/meta-heuristic
- Di chuyển theo hướng có các đỉnh gần đỉnh truy vấn $q$ nhất

#box(
  height: 355pt,
  grid(
    columns: (60%, auto),
    gutter: 20pt,
    [
      #[
        #set text(size: 15pt)
        #figure(
          kind: "algorithm",
          supplement: [Thuật toán],

          pseudocode-list(
            hooks: .5em,
            booktabs: true,
            numbered-title: [Tìm kiếm trên KNNG #h(100%)],
          )[
            + *fucntion* KNNGquery(G, q, k)
              + *variable* visited = generateStartingNodes(G)   
              + *variable* min_heap((u, v) -> compare(d(u, q), d(v, q))) = visited
              + *while* stopping conditions not met
                + *variable* u = min_heap.pop()
                + *for* v *in* neighbors(u)
                  + *if* v *not in* visited
                    + visited.add(v)
                    + min_heap.add(v)
          ],
        )
      ]
    ],
    [
      #set text(size: 16pt)
      Độ phức tạp thuật toán là $cal(O)(m (log(m) + k_"graph" (d + log(m))))$\
      -- $m$ lần lặp\
      -- Mỗi đỉnh đồ thị có $k_"graph"$ hàng xóm

      Thực tế nhanh hơn brute-force nhiều
    ],
  ),
)

#figure(
  image("../images/knns1.png", width: 50%),
  caption: "Chọn ngẫu nhiên đỉnh số 4 để bắt đầu",
)

#figure(
  image("../images/knns2.png", width: 50%),
  caption: "Thăm đỉnh 4, xét hàng xóm là 2 và 3",
)

#figure(
  image("../images/knns3.png", width: 50%),
  caption: "Thăm đỉnh 2, xét hàng xóm là 1 và 3",
)

#figure(
  image("../images/knns3.png", width: 50%),
  caption: "Thăm đỉnh 2, xét hàng xóm là 1 và 3",
)

#figure(
  image("../images/knns4.png", width: 50%),
  caption: "Thăm đỉnh 1, xét hàng xóm là 3 và 5",
)


#align(top)[
  === Cập nhật
]

- Không có hỗ trợ tốt thao tác cập nhật
- Cập nhật cục bộ
- Tái xây dựng sau 1 khoảng thời gian

#pagebreak()

#align(top)[
  === Nhận xét
]

- Ưu
  - Đơn giản
  - Thể hiện cấu trúc cục bộ của dataset
- Nhược
  - Không hỗ trợ cập nhật
  - Chất lượng đồ thị phụ thuộc dataset

#figure(
  image("../images/knng.png", width: 50%),
  caption: "Nhược điểm của KNNG",
)

- Phù hợp với dataset:
  - Tĩnh
  - Dày
  - Kích cỡ tương đối
