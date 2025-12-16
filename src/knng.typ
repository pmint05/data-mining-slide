#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "@preview/lovelace:0.3.0": *

== K-Nearest-Neighbor Graph

#v(-2.2cm)

#figure(
  image("../images/dm14.png", width: 40%),
  caption: "Một ví dụ với k = 3. (có thể vẽ lại, khoanh vùng để thấy rõ hơn)",
)

#pagebreak()

*NN-Descent*

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
            numbered-title: [Tìm $k$ điểm gần nhất #h(100%)],
          )[
            + *function* buildNNDescent(pts)
              + *for* $u$ *in* pts *do*
              + randomly pick $k$ other nodes
              + *while* number of updates < threshold *do*
              + *for* $u$ *in* pts *do*
                + *for* $v$ *in* neighbors($u$) *do*
                + *for* $v'$ *in* neighbors($v$) *do*
                  + compute $d(u, v')$
                + find $k$ closest nodes to $u$, update $u$'s neighbor list
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
      -- Hoạt động với mọi hàm khoảng cách.\
      -- Sử dụng thêm ít bộ nhớ.\
      -- Độ chính xác cao (>90% với bộ dữ liệu thực tế theo tác giả, tốt hơn so với LSH)\
      -- Dễ cài đặt.
    ],
  ),
)
