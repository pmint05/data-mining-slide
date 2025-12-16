== Small World Graph
- Hiện tượng "thế giới nhỏ":  Các cá nhân trong những mạng xã hội rất lớn vẫn được kết nối với nhau thông qua những chuỗi quen biết ngắn.
#figure(
  image("/images/swg_1.png", width:50%),
  caption: "Quy luật \"Sáu bậc cách biệt\"",
)
#pagebreak()
- Đồ thị thế giới nhỏ (SWG): Một đồ thị K-NNG được bổ sung thêm một số cạnh ngẫu nhiên tầm xa, nhờ đó có được các đặc tính của thế giới nhỏ (Small world characteristic)
#figure(
  image("/images/swg_2.png", width: 40%),
  caption: ""
)
#pagebreak()
- Kết quả: Các cụm (cluster) ở xa nhau được kết nối, độ dài đường đi trung bình ngắn nhất giữa hai đỉnh được giảm mạnh (hoặc từ không tồn tại trở thành tồn tại), qua đó tạo cho đồ thị tính điều hướng (navigable).
#figure(
  image("/images/swg_3.png", width: 35%),
  caption: "Tác dụng của cạnh tầm xa"
)
- Trong thực tế, NSWG nhanh chóng được tiếp nối bởi HNSWG: "đồ thị thế giới nhỏ *phân cấp được*"