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

#let rimg(path, width) = box(
  radius: 0.6em,
  clip: true,
  image(path, height: 355pt),
)

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

= Giới thiệu
== Giới thiệu <touying:hidden>

#grid(
  columns: (auto, 1fr, auto),
  [
    #figure(
      [#rimg("/images/for_2.png", 100%) #v(-0pt)],
      caption: [For?],
    )
  ],
  [
    #figure(
      [#image("/images/present.png", width: 80%) #v(0pt)],
      caption: [Present],
    )
  ],
  [
    #figure(
      [#rimg("images/find.jpg", 100%) #v(-0pt)],
      caption: [Find],
    )
  ],
)


= Ứng dụng thực tế

== Hệ thống đề xuất

#figure(
  [
    #rimg("images/youtube-recommended.png", 95%) #v(-0pt)],
  caption: [Hệ thống đề xuất trên YouTube],
)
#figure(
  [#image("images/recommendation-types.svg", width: 80%) #v(20pt)],
  caption: [Các loại hệ thống đề xuất],
)
== Nhận diện trùng lặp văn bản
#figure(
  [#rimg("images/turnitin.png", 85%) #v(0pt)],
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
  [#rimg("images/google-lens.png", 86%) #v(0pt)],
  caption: [Tìm kiếm hình ảnh tương tự sử dụng Google Lens],
)
= Biểu diễn dữ liệu

== Các loại dữ liệu

#align(top)[
  === Vector
]
#figure(
  image("images/vector-1.png", width: 100%),
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
      image("images/dm02.png", width: 80%),
      caption: "Đạo hàm",
    )
  ],
  align(left)[
    #figure(
      image("images/dm04.png", width: 93%),
      caption: "Nhân ma trận",
    )
  ],
)

#pagebreak()

- Có thể đo khoảng cách một cách nhanh chóng và dễ dàng

#figure(
  image("images/dm05.png", width: 70%),
  caption: "Khoảng cách vector trong không gian",
)

#pagebreak()

- Dễ cải tiến tốc độ sử dụng GPU
- Tạo ra không gian vector liên tục giúp mô hình có thể tự hiểu ngữ nghĩa

  #figure(
    image("images/dm06.png", width: 80%),
    caption: "Không gian các từ",
  )


=== Probability and statistic

=== Hashing

=== Token sequence



= Định nghĩa tương đồng

== Tương đồng là gì?
Trong data mining, "độ tương đồng" được hiểu là độ đo mức độ giống nhau giữa hai đối tượng dữ liệu hay mức độ chồng lặp khi biểu diễn chúng dưới dạng tập hợp hoặc vector đặc trưng.

== Các đối tượng như thế nào thì được coi là tương đồng?
Hai đối tượng được coi là tương đồng khi chúng chia sẻ nhiều đặc trung chung nhau, tức là có mức độ trùng lặp cao giữa các biểu diễn của chúng.


= Các phép đo độ tương đồng

== Jaccard Similarity

#grid(
  columns: 2,
  [
    #figure(
      [#image("images/jaccard-venn.svg", width: 60%) #v(10pt)],
      caption: [Jaccard Similarity],
    )
  ],
  [
    $
      J(A, B) = (A inter B) / (A union B)
    $
  ],
)

== Phép đo khoảng cách

#align(top)[
  === $L_p$ norm
  Dạng tổng quát:
  $
    d_p (x, y) = (sum_(i=1)^n |x_i - y_i|^p)^(1/p)
  $
]

#pagebreak()
Với p = 1, ta có khoảng cách Manhattan:

#grid(
  columns: 2,
  [
    #figure(
      [#image("images/manhattan-distance.svg", width: 60%) #v(10pt)],
      caption: [Manhattan Distance],
    )
  ],
  [
    $
      d_1 (x, y) = sum_(i=1)^n |x_i - y_i|
    $
  ],
)

#pagebreak()
Với p = 2, ta có khoảng cách Euclidean:

#grid(
  columns: 2,
  [
    #figure(
      [#image("images/euclidean-distance.svg", width: 60%) #v(10pt)],
      caption: [Euclidean Distance],
    )
  ],
  [
    $
      d_2 (x, y) = sqrt(sum_(i=1)^n |x_i - y_i|^2)
    $
  ],
)


=== Jaccard Distance
$
  d_J (A, B) = 1 - J(A, B)
$
Trong đó $J(A, B)$ là Jaccard Similarity giữa hai tập $A$ và $B$.
=== Cosine Similarity
#grid(
  columns: 2,
  [
    #figure(
      [#image("images/cosine-similarity.svg", width: 60%) #v(10pt)],
      caption: [Cosine Similarity],
    )
  ],
  [
    $
      cos(theta) = (A dot B) / (||A|| * ||B||)
    $
  ],
)


=== Edit Distance
=== Hamming Distance

== So sánh


= Các kỹ thuật tìm cặp tương đồng

== Tìm chính xác
#align(top)[
  === K-d Tree
  *Cấu trúc cây*
]
#let bent-edge(from, to, ..args) = {
  let midpoint = (from, 50%, to)
  let vertices = (
    from,
    (from, "|-", midpoint),
    (midpoint, "-|", to),
    to,
  )
  edge(..vertices, "-|>", ..args)
}

#v(-2.4cm)

#figure(
  diagram(
    node-stroke: luma(20%),
    edge-corner-radius: none,
    spacing: (10pt, 20pt),
    node-inset: 10pt,

    // Nodes
    node((1, 0), [*`Node`*], name: <a>),
    node((0, 3), [`cut_dim`\ chiều dùng để chia], name: <b>),
    node((2, 3), [`cut_val`\ điểm được dùng để chia], name: <c>),


    // Edges
    bent-edge(<a>, <b>),
    bent-edge(<a>, <c>),
  ),
  caption: [Cấu trúc K-d Tree],
)


#figure(
  image("images/dm07.png", width: 90%),
  caption: "Ví dụ cây với một tập điểm 2D",
)

#pagebreak()
*Xây dựng cây*

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
            numbered-title: [Xây dựng cây K-d Tree #h(100%)],
          )[
            + *function* build($P$, depth)
              + *if* $P$ is empty *then*
                + *return* None
              + *if* $|P| = 1$ *then*
                + *return* Node(depth mod $k$, $P[0]$, None, None)
              + mid $<-$ midpoint to partition $P$ into $P_0$ and $P_1$ by depth mod $k$
              + left_node $<-$ build($P_0$, depth + 1)
              + right_node $<-$ build($P_1$, depth + 1)
              + *return* Node(depth mod $k$, mid, left_node, right_node)
          ],
        )
      ]
    ],
    [
      #set text(size: 16pt)
      Độ phức tạp:
      - Giả sử ở mỗi bước đệ quy ta chia đôi tập điểm $=> cal(O)(n log n)$
      - Tìm trung vị:
        - Quicksort: $cal(O)(n log^2 n)$
        - Median of medians: $cal(O)(n log n)$
        - Duy trì $k$ danh sách sắp xếp theo từng chiều: $cal(O)(n k log n)$
    ],
  ),
)

*Chèn*

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
            numbered-title: [Chèn điểm vào cây K-d Tree #h(100%)],
          )[
            + *function* insert($x$, node, depth)
              + *if* node is empty *then*
                + *return* Node(depth mod $k$, $x$, None, None)
              + *if* $x$ == node.data *then*
                + *return* error "duplicate"
              + cd $<-$ depth mod $k$
              + *if* $x[$cd$] <$ node.data$[$cd$]$ *then*
                + node.left $<-$ insert($x$, node.left, depth + 1)
              + *else*
                + node.right $<-$ insert($x$, node.right, depth + 1)
              + *return* node
          ],
        )
      ]
    ],
    [
      #set text(size: 16pt)
      Độ phức tạp:
      - Ngẫu nhiên: $cal(O)(log n)$
      - Tồi nhất: $cal(O)(n)$
    ],
  ),
)

*Tìm điểm có chiều $d$ nhỏ nhất*

#[
  #set text(size: 14pt)
  #figure(
    kind: "algorithm",
    supplement: [Thuật toán],

    pseudocode-list(
      hooks: .5em,
      booktabs: true,
      numbered-title: [Tìm điểm có chiều $d$ nhỏ nhất #h(100%)],
    )[
      + *function* findMin(root, d)
        + *if* root is empty *then*
        + *return* None
        + *if* root.cut_dim == d *then*
        + *if* root.left is empty *then*
          + *return* root
        + *return* findMin(root.left, d)
        + *else*
        + left_min $<-$ findMin(root.left, d)
        + right_min $<-$ findMin(root.right, d)
        + res $<-$ root
        + *for* candidate *in* [left_min, right_min] *do*
          + *if* candidate != None *and* candidate.point[d] < res.point[d] *then*
          + res $<-$ candidate
        + *return* res
    ],
  )
]
*Xóa*

#[
  #set text(size: 9.9pt)
  #figure(
    kind: "algorithm",
    supplement: [Thuật toán],

    pseudocode-list(
      hooks: .5em,
      booktabs: true,
      numbered-title: [Xóa điểm trong cây K-d Tree #h(100%)],
    )[
      + *function* delete(root, point, depth)
        + *if* root is empty *then*
        + *return* None
        + *if* root.point == point *then*
        + *if* root.right is not empty *then*
          + minNode $<-$ findMin(root.right, root.cut_dim)
          + root.point $<-$ minNode.point
          + root.right $<-$ delete(root.right, minNode.point, depth + 1)
        + *else if* root.left is not empty *then*
          + minNode $<-$ findMin(root.left, root.cut_dim)
          + root.point $<-$ minNode.point
          + root.right $<-$ delete(root.left, minNode.point, depth + 1)
          + root.left $<-$ None
        + *else*
          + *return* None
        + *return* root
        + axis $<-$ depth mod $k$
        + *if* point[axis] < root.point[axis] *then*
        + root.left $<-$ delete(root.left, point, depth + 1)
        + *else*
        + root.right $<-$ delete(root.right, point, depth + 1)
        + *return* root
    ],
  )
]

#grid(
  columns: 3,
  [
    #figure(
      image("images/dm09.png", width: 70%),
      caption: "Tồn tại con bên phải",
    )
  ],
  [
    #figure(
      [
        #image("images/dm10.png", width: 70%),
      ],
      caption: "Không tồn tại \ncon bên phải",
    )
  ],
  [
    #figure(
      [
        #image("images/dm11.png", width: 70%)
        #v(-0.88cm)
      ],
      caption: "Không tồn tại \ncon bên phải",
    )
  ],
)

#pagebreak()


#align(top)[
  *Tìm $k$ điểm gần nhất.*
  #v(2cm)
  #grid(
    columns: 2,
    [
      #figure(
        image("images/kd-split-2.svg", width: 100%),
        caption: "Cắt tỉa giúp giảm số lượng điểm duyệt",
      )
    ],
    [
      #figure(
        image("images/kd-split-1.svg", width: 100%),
        caption: "Cắt tỉa không làm giảm số lượng điểm cần duyệt",
      )
    ],
  )

]

#[
  #set text(size: 9.5pt)
  #figure(
    kind: "algorithm",
    supplement: [Thuật toán],

    pseudocode-list(
      hooks: .5em,
      booktabs: true,
      numbered-title: [Tìm $k$ điểm gần nhất #h(100%)],
    )[
      + *function* kNearestNeighbor(root, depth, point, k)
        + *if* root is empty *then*
        + *return*
        + cut_dim $<-$ depth mod $d$
        + *if* point[cut_dim] < root.cut_val[cut_dim] *then*
        + *if* root.left is not empty *then*
          + kNearestNeighbor(root.left, depth + 1, point, k)
        + estimated_dist $<-$ $"(point[cut_dim] - root.cut_val[cut_dim])"^2$
        + *if* estimated_dist $<=$ pq.maxDist() *or* len(pq) < k *then*
          + *if* root.right is not empty *then*
          + kNearestNeighbor(root.right, depth + 1, point, k)
          + pq.add(root.cut_val)
        + *else if* point[cut_dim] > root.cut_val[cut_dim] *then*
        + *if* root.right is not empty *then*
          + kNearestNeighbor(root.right, depth + 1, point, k)
        + estimated_dist $<-$ $"(point[cut_dim] - root.cut_val[cut_dim])"^2$
        + *if* estimated_dist $<=$ pq.maxDist() *or* len(pq) < k *then*
          + *if* root.left is not empty *then*
          + kNearestNeighbor(root.left, depth + 1, point, k)
          + pq.add(root.cut_val)
        + *else*
        + *if* root.left is not empty *then*
          + kNearestNeighbor(root.left, depth + 1, point, k)
        + *if* root.right is not empty *then*
          + kNearestNeighbor(root.right, depth + 1, point, k)
        + pq.add(root.cut_val)
    ],
  )
]


#align(top)[
  === Ball Tree
  *Cấu trúc cây*
]
#v(-2.2cm)
#figure(
  diagram(
    node-stroke: luma(20%),
    edge-corner-radius: none,
    spacing: (10pt, 20pt),
    node-inset: 10pt,

    // Nodes
    node((2.5, 0), [*`Node`*], name: <a>),
    node((0, 3), [`center`\ tâm node], name: <b>),
    node((2, 3), [`radius`\ bán kính node], name: <c>),
    node((3, 3), [`left`\ con bên trái], name: <d>),
    node((4, 3), [`right`\ con bên phải], name: <e>),


    // Edges
    bent-edge(<a>, <b>),
    bent-edge(<a>, <c>),
    bent-edge(<a>, <d>),
    bent-edge(<a>, <e>),
  ),
  caption: [Cấu trúc Ball Tree],
)


#figure(
  image("images/balltree-illus.png", width: 90%),
  caption: "Minh họa Ball Tree",
)


*Xây dựng cây*

#box(
  height: 355pt,
  grid(
    columns: (60%, auto),
    gutter: 20pt,
    [
      #[
        #set text(size: 12.5pt)
        #figure(
          kind: "algorithm",
          supplement: [Thuật toán],

          pseudocode-list(
            hooks: .5em,
            booktabs: true,
            numbered-title: [Xây dựng cây Ball Tree #h(100%)],
          )[
            + *function* CONSTRUCT_BALLTREE($D$, max_leaf_size)
              + $N = |D|$
              + center $<-$ CENTROID($D$)
              + radius $<-$ $max_(x in D) ||x - "center"||$
              + node $<-$ new Node(center=center, radius=radius)
              + *if* $N <=$ max_leaf_size *then*
                + node.points $<-$ $D$
                + node.is_leaf $<-$ True
                + *return* node
              + *else*
                + $p_L <-$ $arg max_(x in D) ||x - "center"||$
                + $p_R <-$ $arg max_(x in D) ||x - p_L||$
                + $D_"left" <-$ ${ x in D | ||x - p_L|| <= ||x - p_R|| }$
                + $D_"right" <-$ $D \\ D_"left"$
                + node.left $<-$ CONSTRUCT_BALLTREE($D_"left"$, max_leaf_size)
                + node.right $<-$ CONSTRUCT_BALLTREE($D_"right"$, max_leaf_size)
                + *return* node
          ],
        )
      ]
    ],
    [
      #set text(size: 16pt)
      Độ phức tạp:
      - Trung bình: $cal(O)(N d log N)$
      - Xấu nhất : $cal(O)(N^2 d)$ khi split rất lệch
    ],
  ),
)

*Chèn*

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
            numbered-title: [Chèn điểm vào Ball Tree #h(100%)],
          )[
            + *function* INSERT(node, $x$)
              + *if* node.is_leaf *then*
                + node.points.append($x$)
                + *if* $|"node.points"| >$ max_leaf_size *then*
                  + rebuild(node)
              + *else*
                + *if* dist($x$, node.left.center) $<$ dist($x$, node.right.center) *then*
                  + INSERT(node.left, $x$)
                + *else*
                  + INSERT(node.right, $x$)
                + update(node.center, node.radius)
          ],
        )
      ]
    ],
    [
      #set text(size: 16pt)
      Độ phức tạp:
      - Trung bình: $cal(O)(d log N)$
      - Xấu nhất : $cal(O)(d N)$
    ],
  ),
)

*Xóa*

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
            numbered-title: [Xóa điểm khỏi Ball Tree #h(100%)],
          )[
            + *function* DELETE(node, $x$)
              + *if* node.is_leaf *then*
                + remove($x$, node.points)
              + *else*
                + *if* dist($x$, node.left.center) $<$ dist($x$, node.right.center) *then*
                  + DELETE(node.left, $x$)
                + *else*
                  + DELETE(node.right, $x$)
                  + update(node.center, node.radius)
          ],
        )
      ]
    ],
    [
      #set text(size: 16pt)
      Độ phức tạp:
      - Trung bình: $cal(O)(d log N)$
      - Xấu nhất : $cal(O)(d N)$
    ],
  ),
)

*Tìm $k$ điểm gần nhất*\
#box(
  height: 355pt,
  grid(
    columns: (60%, auto),
    gutter: 20pt,
    [
      #[
        #set text(size: 9pt)
        #figure(
          kind: "algorithm",
          supplement: [Thuật toán],

          pseudocode-list(
            hooks: .5em,
            booktabs: true,
            numbered-title: [Tìm $k$ điểm gần nhất #h(100%)],
          )[
            + *function* BALLTREE_KNN(root, q, k)
              + heap $<-$ empty max-heap
              + *function* SEARCH(node)
              + *if* node is leaf *then*
                + *for* p *in* node.points *do*
                  + d $<-$ dist(q, p)
                  + *if* heap.size < k *then*
                    + heap.push((d, p))
                  + *else if* d < heap.max_key *then*
                    + heap.replace_max((d, p))
              + *return*
              + dL $<-$ max(0, dist(q, node.left.center) - node.left.radius)
              + dR $<-$ max(0, dist(q, node.right.center) - node.right.radius)
              + *if* dL < dR *then*
                + *if* heap.size < k *or* dL $<=$ heap.max_key *then*
                  + SEARCH(node.left)
                + *if* heap.size < k *or* dR $<=$ heap.max_key *then*
                  + SEARCH(node.right)
              + *else*
                + *if* heap.size < k *or* dR $<=$ heap.max_key *then*
                  + SEARCH(node.right)
                + *if* heap.size < k *or* dL $<=$ heap.max_key *then*
                  + SEARCH(node.left)
              + SEARCH(root)
              + *return* heap.items sorted asc by distance
          ],
        )
      ]
    ],
    [
      #set text(size: 16pt)
      Độ phức tạp:
      - Trung bình: $cal(O)(d log N)$
        - $d$ để tính khoảng cách từ truy vấn đến các node con trong cây
        - $log N$ số tầng trung bình của cây
      - Xấu nhất : $cal(O)(d N)$
    ],
  ),
)
== Tìm gần đúng
=== LSH
=== K-NNG
