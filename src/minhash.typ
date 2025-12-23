== Hashing


=== Minhashing
- Minhash là một phương pháp tạo ra các biểu diễn thu nhỏ cho các tập (sets), gọi là các signature
#pagebreak()
- Ma trận đặc trưng (Characteristic matrix)
  - Biểu diễn một "tập các tập"
  - Mỗi cột ứng với một tập
  - Mỗi hàng ứng với một phần tử trong tập tất cả các phần tử
  - Mỗi ô $(r, c) = 1$ nếu tập thứ $c$ chứa phần tử thứ $r$
#figure(image("/images/minhash_1.png"), caption: "Ma trận đặc trưng")
#pagebreak()
- Minhash một tập
  - Lấy một hoán vị của các hàng
  - Giá trị Minhash của một tập (ứng với cột $c$) tương ứng với phần tử của hàng đầu tiên $r$ sao cho giá trị tại $(r, c) = 1$
#figure(
  image("../images/minhash_2.png"),  caption:"Minh họa về minhashing"
)
#pagebreak()
- Minhash và độ tương đồng Jaccard

#pagebreak()
- *Minhash Signature* của một set
- Với $n$ hoán vị hàng $h_1, h_2,...,h_n$, Minhash Signature của tập S là vector $[h_1(S), h_2(S),...,h_n (S)]$
- Khi xếp Minhash Signature của nhiều set lại với nhau ta được 1 *signature matrix*
- Trong thực tế, việc lấy nhiều hoán vị hàng của characteristic matrix với kích cỡ lớn rất tốn thời gian
#pagebreak()
- Ta có thể mô phỏng một hoán vị bằng cách dùng 1 hàm băm với số bucket bằng số row (map $k$ giá trị vào $k$ buckets)
- Signature matrix có thể được xây dựng như sau:
  - Chọn $n$ hàm băm thỏa mãn yêu cầu
  - Gọi `SIG(i, c)` là giá trị của signature matrix cho cột $c$ và hàm băm thứ $i$. Khởi tạo toàn bộ signature matrix với giá trị $infinity$
  - Với mỗi row r:
    - Tính $h_1(r), h_2(r),..., h_n (r)$
    - Với mỗi cột $c$:
      - nếu $(r, c) = 0$, bỏ qua 
      - nếu $(r, c) = 1$, update toàn bộ cột:
        ``` 
        for i = 1 to n:
          SIG(i, c) = min(SIG(i,c), h_i(r))
        ```
#figure(
  image("/images/minhash_3.png"),
  caption: "Ví dụ về tạo minhash signature"
)
#pagebreak()
#grid(
  columns: 2,
  gutter: 1em,
  table(
    columns: (auto, auto, auto, auto, auto),
    align: center,
    table.header(
    [], [$S_1$], [$S_2$], [$S_3$], [$S_4$],
    $h_1$, $infinity$, $infinity$, $infinity$, $infinity$,
    $h_2$, $infinity$, $infinity$, $infinity$, $infinity$
  ),
  ),
    table(
    columns: (auto, auto, auto, auto, auto),
    align: center,
    table.header(
    [], [$S_1$], [$S_2$], [$S_3$], [$S_4$],
    $h_1$, $1$, $infinity$, $infinity$, $1$,
    $h_2$, $1$, $infinity$, $infinity$, $1$
  ),
  ),
    table(
    columns: (auto, auto, auto, auto, auto),
    align: center,
    table.header(
    [], [$S_1$], [$S_2$], [$S_3$], [$S_4$],
    $h_1$, $1$, $infinity$, $2$, $1$,
    $h_2$, $1$, $infinity$, $4$, $1$
  ),
  ),
    table(
    columns: (auto, auto, auto, auto, auto),
    align: center,
    table.header(
    [], [$S_1$], [$S_2$], [$S_3$], [$S_4$],
    $h_1$, $1$, $3$, $2$, $1$,
    $h_2$, $1$, $2$, $4$, $1$
  ),
  ),
    table(
    columns: (auto, auto, auto, auto, auto),
    align: center,
    table.header(
    [], [$S_1$], [$S_2$], [$S_3$], [$S_4$],
    $h_1$, $1$, $3$, $2$, $1$,
    $h_2$, $0$, $2$, $0$, $0$
  ),
  ),
    table(
    columns: (auto, auto, auto, auto, auto),
    align: center,
    table.header(
    [], [$S_1$], [$S_2$], [$S_3$], [$S_4$],
    $h_1$, $1$, $3$, $0$, $1$,
    $h_2$, $0$, $2$, $0$, $0$
  ),
  )
  )
- Từ signature matrix này, có thể ước lượng được mức tương đồng Jaccard giữa các set. Tuy nhiên với giá trị $n$ bé $(n=2)$, ta thấy các ước lượng ở đây không chính xác.