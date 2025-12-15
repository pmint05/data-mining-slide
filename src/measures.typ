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
=== Hamming Distance

== So sánh

