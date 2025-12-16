== Hierarchical Navigable Small World
- HNSWG cũng bổ sung các cạnh ngẫu nhiên tầm xa để cải thiện hiệu năng
- Tuy nhiên, thay vì chèn trực tiếp vào đồ thị, HNSWG phân tách các cạnh thành các tầng (layers), tạo ra cấu trúc phân cấp
- Các tầng có độ mật độ cạnh tăng dần: tầng trên cùng thưa nhất (vì vậy có nhiều cạnh dài nhất), và tầng dưới cùng dày nhất, gần với một K-NNG
#figure(
  image("/images/hnswg_1.png", width: 80%),
  caption: "Minh họa HNSWG"
)
#pagebreak()
=== Tìm kiếm trong HNSWG:
  - Bắt đầu từ tầng trên cùng
  - Tìm kiếm (các) node gần nhất với node đang tìm
  - Hạ xuống tầng tiếp theo và tiếp tục tìm kiếm với các nodes vừa thu được
  - Lặp lại quá trình này đến tầng dưới cùng
#figure(
  image("/images/hnswg_2.png", width: 80%),
  caption: "Tìm kiếm trong HNSWG"
)

=== Chèn node (Insertion)
- Khác với KNNG, HNSWG có thể được xây dựng theo cách tăng dần (incremental)
- Phân bố node: xác suất để một node tồn tại ở tầng tiếp theo là p, do đó số lượng node ở mỗi tầng giảm theo cấp số mũ.
- Giả sử nút u cần được chèn vào các tầng từ 0 đến L: tại mỗi tầng, u được kết nối với các nút gần nó nhất.
#figure(
  image("/images/hnswg_3.png", width: 80%),
  caption: "Chèn node mới trong HNSWG"
)
- Có thể thấy quy trình insert tương tự như tìm kiếm: duyệt đồ thị từ trên xuống, tận dụng các tầng trên để nhanh chóng tiếp cận nghiệm tối ưu và tinh chỉnh dần kết quả tìm kiếm qua các tầng.
#pagebreak()
=== Xóa node (Deletion)
- Phiên bản HNSWG trong bài báo gốc không hỗ trợ xóa thực sự (true deletion)
#pagebreak()
- Xóa giả (deletion flag):
  - Đánh dấu node là "đã xóa"
  - Khi cần tìm kiếm, thuật toán bỏ qua các node này
- Ưu điểm: nhanh, dễ và an toàn
- Nhược điểm: đồ thị sẽ tích tụ dần nhiều các node chết này
#pagebreak()
- Xóa cứng (hard delete):
  - Thực sự xóa node hoàn toàn khỏi đồ thị
  - Điều chỉnh lại các nodes kề
- Vấn đề: 
  - Sửa chữa cục bộ tốn kém
  - Độ chính xác tìm kiếm có thể suy giảm nếu quá trình sửa chữa không được thực hiện tốt.


