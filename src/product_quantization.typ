== Product quantization

=== Quantization
#grid(
  columns: (auto, auto),
  align(left)[
    #figure(
      image("../images/dm21.png", width: 100%),
      caption: "Giảm chiều dữ liệu",
    )
  ],
  align(left)[
    #figure(
      image("../images/dm20.png", width: 80%),
      caption: "Lượng tử hoá",
    )
  ],
)

=== Vector quantization

#figure(
  image("../images/vector-quantization.jpg", width: 80%),
  caption: "Ví dụ về vector quantization",
)

=== Product Quantization

#figure(
  image("../images/prod-quant.svg", width: 85%),
  caption: "Minh họa product quantization",
)

#figure(
  [
    ```python
    def symmetric_distance(self, codes_a, codes_b):
        distance = 0
        for j in range(self.m):
            c_a = self.codebooks[j][codes_a[j]]
            c_b = self.codebooks[j][codes_b[j]]
            distance += np.sum((c_a - c_b) ** 2)
        return distance
    ```
    #v(20pt)
  ],
  caption: "Tính khoảng cách đối xứng",
)

#pagebreak()
#grid(
  columns: (60%, auto),
  gutter: 2em,
  [
    #set text(size: 15pt)
    #figure(
      [
        ```python
        def compute_distance_table(self, query):
            distance_table = np.zeros((self.m, self.k))

            for j in range(self.m):
                start_idx = j * self.d_sub
                end_idx = (j + 1) * self.d_sub
                query_sub = query[start_idx:end_idx]

                # Distance from query subvector to each centroid
                distance_table[j] = np.sum(
                    (query_sub - self.codebooks[j]) ** 2,
                    axis=1
                )

            return distance_table

        def adc_distance(self, distance_table, code):
            distance = 0
            for j in range(self.m):
                distance += distance_table[j, code[j]]
            return distance
        ```
        #v(20pt)
      ],
      caption: "Tính khoảng cách bất đối xứng (ADC)",
    )
  ],

  [
    Độ phức tạp: $ O(k D + N m) approx O(N m) $
  ],
)

#pagebreak()

#figure(
  image("/images/lopq.png")
)