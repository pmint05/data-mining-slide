#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "@preview/lovelace:0.3.0": *

= Các kỹ thuật tìm cặp tương đồng

== K-D Tree

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
  caption: [Cấu trúc $k$-d Tree],
)


#figure(
  image("../images/dm07.png", width: 90%),
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

*Chèn một điểm vào cây*

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
*Xóa một điểm khỏi cây*

#[

  #grid(
    columns: 2,
    [
      #set text(size: 12.5pt)
      #figure(
        kind: "algorithm",
        supplement: [Thuật toán],

        pseudocode-list(
          hooks: .5em,
          booktabs: true,
          numbered-title: [Xóa điểm trong cây K-d Tree - Trường hợp 1],
        )[
          + *function* delete(root, point, depth)
            + *if* root is empty *then*
              + *return* None
            + *if* root.point == point *then*
              + *if* root.right is not empty *then*
                + minNode $<-$ findMin(root.right, root.cut_dim)
                + root.point $<-$ minNode.point
                + root.right $<-$ delete(root.right, minNode.point, depth + 1)
          //   + *else if* root.left is not empty *then*
          //     + minNode $<-$ findMin(root.left, root.cut_dim)
          //     + root.point $<-$ minNode.point
          //     + root.right $<-$ delete(root.left, minNode.point, depth + 1)
          //     + root.left $<-$ None
          //   + *else*
          //     + *return* None
          // + *return* root
          // + axis $<-$ depth mod $k$
          // + *if* point[axis] < root.point[axis] *then*
          // + root.left $<-$ delete(root.left, point, depth + 1)
          // + *else*
          // + root.right $<-$ delete(root.right, point, depth + 1)
          // + *return* root
        ],
      )
    ],
    [
      #figure(
        image("../images/dm09.png", width: 70%),
        caption: "Tồn tại con bên phải",
      )
    ]
  )

]

#[

  #grid(
    columns: 2,
    [
      #set text(size: 12pt)
      #figure(
        kind: "algorithm",
        supplement: [Thuật toán],

        pseudocode-list(
          hooks: .5em,
          booktabs: true,
          numbered-title: [Xóa điểm trong cây K-d Tree - Trường hợp 2],
        )[
            + *else if* root.left is not empty *then*
              + minNode $<-$ findMin(root.left, root.cut_dim)
              + root.point $<-$ minNode.point
              + root.right $<-$ delete(root.left, minNode.point, depth + 1)
              + root.left $<-$ None
            + *else*
              + *return* None
            + axis $<-$ depth mod $k$
            + *if* point[axis] < root.point[axis] *then*
              + root.left $<-$ delete(root.left, point, depth + 1)
            + *else*
              + root.right $<-$ delete(root.right, point, depth + 1)
            + *return* root
        ],
      )
    ],
    [
      #figure(
        image("../images/dm10.png", width: 50%),
        caption: "Không tồn tại con bên phải",
      )
    ]
  )

]

// #grid(
//   columns: 3,
//   [
//     #figure(
//       image("../images/dm09.png", width: 70%),
//       caption: "Tồn tại con bên phải",
//     )
//   ],
//   [
//     #figure(
//       image("../images/dm10.png", width: 70%),
//       caption: "Không tồn tại \ncon bên phải",
//     )
//   ],
//   [
//     #figure(
//       image("../images/dm11.png", width: 70%),
//       caption: "Không tồn tại \ncon bên phải",
//     )
//   ],
// )

#pagebreak()


#align(top)[
  *Tìm $k$ điểm gần nhất.*
  #v(2cm)
  #grid(
    columns: 2,
    [
      #figure(
        image("../images/kd-split-2.svg", width: 100%),
        caption: "Cắt tỉa giúp giảm số lượng điểm duyệt",
      )
    ],
    [
      #figure(
        image("../images/kd-split-1.svg", width: 100%),
        caption: "Cắt tỉa không làm giảm số lượng điểm cần duyệt",
      )
    ],
  )

]

#[
  #set text(size: 14pt)
  #figure(
    kind: "algorithm",
    supplement: [Thuật toán],

    pseudocode-list(
      hooks: .5em,
      booktabs: true,
      numbered-title: [Tìm $k$ điểm gần nhất - Cắt tỉa theo nhánh trái],
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
        // + *else if* point[cut_dim] > root.cut_val[cut_dim] *then*
        // + *if* root.right is not empty *then*
        //   + kNearestNeighbor(root.right, depth + 1, point, k)
        // + estimated_dist $<-$ $"(point[cut_dim] - root.cut_val[cut_dim])"^2$
        // + *if* estimated_dist $<=$ pq.maxDist() *or* len(pq) < k *then*
        //   + *if* root.left is not empty *then*
        //   + kNearestNeighbor(root.left, depth + 1, point, k)
        //   + pq.add(root.cut_val)
        // + *else*
        // + *if* root.left is not empty *then*
        //   + kNearestNeighbor(root.left, depth + 1, point, k)
        // + *if* root.right is not empty *then*
        //   + kNearestNeighbor(root.right, depth + 1, point, k)
        // + pq.add(root.cut_val)
    ],
  )
]

#pagebreak()

#[
  #set text(size: 16pt)
  #figure(
    kind: "algorithm",
    supplement: [Thuật toán],

    pseudocode-list(
      hooks: .5em,
      booktabs: true,
      numbered-title: [Tìm $k$ điểm gần nhất - Cắt tỉa theo nhánh phải],
    )[
        + *else if* point[cut_dim] > root.cut_val[cut_dim] *then*
          + *if* root.right is not empty *then*
            + kNearestNeighbor(root.right, depth + 1, point, k)
          + estimated_dist $<-$ $"(point[cut_dim] - root.cut_val[cut_dim])"^2$
          + *if* estimated_dist $<=$ pq.maxDist() *or* len(pq) < k *then*
            + *if* root.left is not empty *then*
              + kNearestNeighbor(root.left, depth + 1, point, k)
            + pq.add(root.cut_val)
        // + *else*
        // + *if* root.left is not empty *then*
        //   + kNearestNeighbor(root.left, depth + 1, point, k)
        // + *if* root.right is not empty *then*
        //   + kNearestNeighbor(root.right, depth + 1, point, k)
        // + pq.add(root.cut_val)
    ],
  )
]

#pagebreak()

#[
  #set text(size: 16pt)
  #figure(
    kind: "algorithm",
    supplement: [Thuật toán],

    pseudocode-list(
      hooks: .5em,
      booktabs: true,
      numbered-title: [Tìm $k$ điểm gần nhất - Không cắt tỉa],
    )[
        + *else*
          + *if* root.left is not empty *then*
            + kNearestNeighbor(root.left, depth + 1, point, k)
          + *if* root.right is not empty *then*
            + kNearestNeighbor(root.right, depth + 1, point, k)
          + pq.add(root.cut_val)
    ],
  )
]

#pagebreak()

- Ưu điểm:
  - Dễ cài đặt
  - Hỗ trợ nhiều tác vụ khác (truy vấn trong một không gian con...)
  - Không cần học tham số
- Nhược điểm:
  - Không phù hợp với dữ liệu có số chiều lớn
  - Khó cập nhật động (gây lệch cây)
  - Không tối ưu cho dữ liệu phân bố không đều (nhiều outlier)
  - Khó prune với các loại hàm khoảng cách != norm $L_1, L_2, L_inf$


== Ball Tree
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
  image("../images/balltree-illus.png", width: 90%),
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

== LSH: Locality Sensitive Hashing

#figure(
  image("../images/normalhash.png", width: 70%),
  caption: [Hash bình thường],
)

#figure(
  image("../images/lsh.png", width: 70%),
  caption: [LSH],
)

#figure(
  image("../images/lshprocess.png", width: 70%),
)

#pagebreak()

=== K-Shingling: Chuyển text → tập shingles

#box(
  height: 300pt,
  grid(columns: (55%, 45%), gutter: 20pt)[

    #set text(size: 13pt)
    #figure(
      kind: "algorithm",
      supplement: [K-Shingling],
      pseudocode-list(hooks: .4em, booktabs: true, numbered-title: [Tạo k-shingles #h(100%)])[
        + *function* K_SHINGLING(doc, $k=5$):
          + shingles ← {}
          + *for* $i = 0$ *to* len(doc) $- k$:
            + shingle ← doc[$i:i+k$]
            + shingles.add(shingle)
            + *return* shingles
      ],
    )
  ][
    #set text(size: 16pt)
    *Ví dụ*: `"the cat sat"` $(k = 3)$
    ```
    {"the", "he ", "cat", "at ", "sat"}
    ```
    #v(1em)
    *Jaccard*: $J(A, B) = (A inter B) / (A union B)$

    *Chuyển text → set để tính Jaccard*
  ],
)

#pagebreak()

=== MinHashing: Sparse → Compact Signature

#box(
  grid(columns: (55%, 45%), gutter: 20pt)[
    #set text(size: 12pt)
    #figure(
      kind: "algorithm",
      supplement: [MinHash],
      pseudocode-list(hooks: .4em, booktabs: true, numbered-title: [Tạo signature #h(100%)])[
        + *function* MINHASH(set, $n=100$):
          + signature ← array($n$, $infinity$)
          + *for* hash_i $= 1$ *to* $n$:
            + π ← random_permutation(vocab)
            + *for* shingle *in* set:
              + $h$ ← π[shingle]
              + signature[hash_i] ← min(signature[hash_i], $h$)
            + *return* signature
      ],
    )
  ][
    #set text(size: 15pt)
    *Key Property*:
    ```
    Pr[minhash(A)=minhash(B)] = J(A,B)
    ```

    #v(1em)
    // *Ví dụ* (vocab=10k → n=100):
    // ```
    // Doc A: 500 shingles → [342, 187, 9052, ...]
    // Doc B: 600 shingles → [342, 201, 9052, ...]
    // ```

    // *Giảm 10kD → 100D (100x nhỏ hơn)*
  ],
)

#pagebreak()

=== Banding: Signature → Candidate Pairs

#figure(
  image("../images/banding1.png", width: 70%),
  caption: [banding],
)

#figure(
  image("../images/banding2.png", width: 70%),
  caption: [banding],
)

#box(
  grid(columns: (55%, 45%), gutter: 20pt)[
    #set text(size: 12pt)
    #figure(
      kind: "algorithm",
      supplement: [Banding],
      pseudocode-list(hooks: .4em, booktabs: true, numbered-title: [Band + Hash #h(100%)])[
        + *function* BAND_HASH(signature, $b=20$, $r=5$):
          + buckets ← {}
          + *for* band = 0 *to* $b - 1$:
            + start ← band $times$ $r$
            + rows ← signature[start:start $+ r$]
            + $h$ ← hash(rows)
            + buckets[$h$].add(doc_id)
        +
          + candidates ← {}
          + *for* bucket *in* buckets.values():
            + *if* len(bucket) $>= 2$:
              + candidates += pairs(bucket)
          + *return* candidates
      ],
    )
  ][
    #set text(size: 14pt)

    *Ví dụ* ($n=100$, $b=20$ bands, $r=5$ rows/band):
    ```
    signature[0:5]    → hash1  → bucket1
    signature[5:10]   → hash2  → bucket2
    ...
    signature[95:100] → hash20 → bucket20
    ```

    #v(1em)
    *S-curve*: $P(s) = 1 - (1-s^r)^b$

    $s=0.8 =>$ $95%$ detect

    $s=0.5 =>$ $45%$ detect

    $s=0.2 =>$ $< 1%$ false positive
  ],
)

#pagebreak()

=== Pipeline Hoàn chỉnh & Tuning

#figure(
  image("/images/lsh-flow.png", width:15%)
)

#pagebreak()

// #columns(2, gutter: 20pt)[
//   ```
//   Text (1MB)
//             ↓ k=5
//   Shingles (~500)
//             ↓ n=100
//   MinHash signature
//             ↓ b=20,r=5
//   20 Bands → Buckets
//             ↓
//   Candidates (0.1%)
//             ↓
//   Verify Jaccard → Top-K
//   ```
// ]
=== Tối ưu Bands

#figure(
  table(
    columns: 4,
    align: horizon,
    table.header[
      *Target $s$*
    ][
      *$b$ (bands)*
    ][
      *$r$ (rows)*
    ][
      *$P$ (detect)*
    ],
    [$>= 0.8$ (duplicate)], [10], [10], [95%],
    [$>= 0.5$ (similar)], [20], [5], [62%],
    [$>= 0.3$ (related)], [50], [2], [78%],
  ),
  caption: [$n = b times r = 100$ hash functions],
)

*S-curve formula*: $P(s) = 1 - (1 - s^r)^b$

#set text(size: 14pt)
*Trade-offs*:
- Nhiều bands ($b$ lớn, $r$ nhỏ): ↑ Recall, ↓ Precision
- Ít bands ($b$ nhỏ, $r$ lớn): ↓ Recall, ↑ Precision

*$10^6$ docs → $10^4$ candidates (thay vì $10^12$ pairs)*



