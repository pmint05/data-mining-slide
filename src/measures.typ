= Các phép đo độ tương đồng

== Jaccard Similarity

#grid(
  columns: 2,
  [
    #figure(
      [#image("../images/jaccard-venn.svg", width: 60%) #v(10pt)],
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
      [#image("../images/manhattan-distance.svg", width: 60%) #v(10pt)],
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
      [#image("../images/euclidean-distance.svg", width: 60%) #v(10pt)],
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
      [#image("../images/cosine-similarity.svg", width: 60%) #v(10pt)],
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

#grid(
  columns: (50%, auto),
  gutter: 2cm,
  [
    #figure(
      [#image("../images/edit-distance-cropped.svg", width: 100%) #v(10pt)],
      caption: [Edit Distance],
    )
  ],
  [
    $d_"edit" ("str1", "str2") =$ số lần chỉnh sửa tối thiểu để biến "str1" thành "str2"

    Nếu gọi:
    - $L(x)$: độ dài chuỗi $x$,
    - $L(y)$: độ dài chuỗi $y$,
    - $L("LCS"(x, y))$: độ dài chuỗi con chung dài nhất của $x$ và $y$,
    thì:
    $ d_"edit" (x, y) = L(x) + L(y) - 2 * L("LCS"(x, y)) $
  ],
)

#pagebreak()

=== Hamming Distance

#grid(
  columns: (50%, auto),
  gutter: 2cm,
  [
    #figure(
      [#image("../images/hamming-distance-cropped.svg", width: 100%) #v(10pt)],
      caption: [Hamming Distance],
    )
  ],
  [
    $d_"Hamming" (x, y) =$ số vị trí mà hai chuỗi $x$ và $y$ khác nhau

    $
      d(x, y) = sum_(i=1)^n [x_i eq.not y_i]
    $
  ],
)

== So sánh

#[
  #set text(size: 14pt)
  #set par(justify: false)
  #figure(
    table(
      columns: 6,
      inset: 8pt,
      stroke: 0.5pt,
      align: (left, left, left, center, left, left),

      [*Độ đo*], [*Loại dữ liệu*], [*Khi nào dùng*], [*Chi phí*], [*Ưu điểm*], [*Nhược điểm*],

      // Euclidean
      [Euclidean],
      [Số liên tục, vector số],
      [Hình học, giảm chiều, k-NN, k-means],
      [$O(d)$],
      [Trực quan, phổ biến],
      [Nhạy scale, outlier; hiệu quả giảm khi $d$ tăng],

      // Cosine
      [Cosine],
      [Vector số, dữ liệu thưa],
      [Hướng vector, TF-IDF, recommendation],
      [$O(d)$],
      [Độc lập độ lớn vector],
      [Không phải là metric; chỉ xét hướng; nhạy với nhiễu],

      // Hamming
      [Hamming], [Binary, categorical (chuỗi cùng độ dài)], [Mã bit, phát hiện lỗi], [$O(d)$], [Đơn giản, nhanh], [Chỉ dữ liệu nhị phân; không phản ánh được mức độ],

      // Jaccard
      [Jaccard],
      [Sets, vector nhị phân],
      [So sánh tập (văn bản, hộ sơ)],
      [$O(|A| + |B|)$],
      [Tập hợp khác kích thước],
      [Khuyết tần suất phần tử; mất thông tin thứ tự, độ lớn],

      // Edit
      [Edit],
      [Chuỗi (sequences, string)],
      [So khớp chuỗi, NLP],
      [$O(m n)$],
      [Nhạy sai lệch nhỏ, chuỗi khác độ dài],
      [Chi phí cao; chỉ cho chuỗi],
    ),
    caption: [So sánh các phép đo độ tương đồng],
  )
]
