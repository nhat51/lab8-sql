CREATE DATABASE LAB8
USE LAB8
GO
CREATE TABLE Customer(
	CustomerID INT PRIMARY KEY,
	CustomerName NVARCHAR(50),
	Address NVARCHAR(100),
	Phone CHAR(10)
)
GO
CREATE TABLE Books(
	BookCode INT PRIMARY KEY,
	Category VARCHAR(10),
	Author VARCHAR(100),
	Publisher VARCHAR(50),
	Title VARCHAR(100),
	Price INT,
	ImStore INT
)
CREATE TABLE BookSold(
	BookSoldId INT PRIMARY KEY NOT NULL,
	CustomerID INT,
	BookCode INT,
	Date DATETIME,
	Price INT,
	Amount INT,
	CONSTRAINT Cus_sold FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
	CONSTRAINT books_booksold FOREIGN KEY (BookCode) REFERENCES Books(BookCode)
)
GO
DROP TABLE Customer
DROP TABLE Books
DROP TABLE BookSold
GO
INSERT INTO Customer VALUES 
(111,N'Nguyễn Quang Nhật',N'Duyên Hà, Thanh Trì, Hà Nội','2974790571'),
(112,N'Vương Quốc Hùng',N'Tứ Hiệp, Thanh Trì, Hà Nội','4902234509'),
(113,N'Tống Kiều Trang',N'Thanh Xuân, Hoàng Mai, Hà Nội','2948901827'),
(114,N'Hoàng Thùy Linh',N'Đại Từ, Hoàng Mai, Hà Nội','1912357189'),
(115,N'Ngô Bá Khá',N'Từ Sơn, Bắc Ninh, Hà Nội','3913943221')
GO
SELECT * FROM Customer
INSERT INTO Books VALUES
(887,'Van Hoc','Nguyen Nhat Anh','NXB Kim Dong','Co Gai Den Tu Hom Qua',50000,33),
(876,'Van Hoc','Tao dinh','NXB Tuoi Tre','Xin Loi, Em Chi la Con Di',20000,21),
(812,'Chinh Tri','Le Kha Phieu','NXB Kim Dong','Duong Loi Cach Mang Cua DCSVN',50000,12),
(843,'Van Hoc','Co Man','NXB Tuoi Tre','Yeu Em Tu Cai Nhin Dau Tien',1000,20),
(817,'Van Hoc','Nguyen Nhat Anh','NXB Kim Dong','Toi La Beto',20000,15)
GO
INSERT INTO BookSold VALUES
(211,111,817,'2019-09-12',20000,1),
(212,111,812,'2018-11-21',150000,3),
(213,112,843,'2019-02-01',1000,1),
(214,112,817,'2020-05-01',60000,3),
(215,113,876,'2010-09-07',140000,7),
(216,113,887,'2020-01-10',50000,1),
(217,114,843,'2019-05-08',30000,3),
(218,114,887,'2018-12-09',10000,2),
(219,115,876,'2020-10-02',80000,4),
(220,115,812,'2020-02-14',50000,1)
GO
--Tạo một khung nhìn chứa danh sách các cuốn sách (BookCode, Title, Price) kèm theo số lượng đã bán được của mỗi cuốn sách.
CREATE VIEW Book_Sold AS
SELECT BookSold.BookCode,Books.Title,BookSold.Price,BookSold.Amount FROM BookSold 
INNER JOIN Books ON Books.BookCode = BookSold.BookCode
SELECT * FROM BooK_Sold

--Tạo một khung nhìn chứa danh sách các khách hàng (CustomerID, CustomerName, Address) kèm theo số lượng các cuốn sách mà khách hàng đó đã mua.
CREATE VIEW Customer_By_Book AS
SELECT Customer.CustomerID,Customer.CustomerName,Customer.Address,BookSold.Amount FROM Customer 
INNER JOIN BookSold ON BookSold.CustomerID = Customer.CustomerID
SELECT * FROM Customer_By_Book

--Tạo một khung nhìn chứa danh sách các khách hàng (CustomerID, CustomerName, Address) đã mua sách kèm theo tên các cuốn sách mà khách hàng đã mua.
CREATE VIEW Customer_Buy_Book_Name AS
SELECT Customer.CustomerID,Customer.CustomerName,Customer.Address,Books.Title FROM Customer
INNER JOIN BookSold ON Customer.CustomerID = BookSold.CustomerID
INNER JOIN Books ON BookSold.BookCode = Books.BookCode
GO
SELECT * FROM Customer_Buy_Book_Name
CREATE VIEW TotalPrice AS
SELECT BookSold.Price,Customer.CustomerName,BoookSold.CustomerID FROM BookSold
INNER JOIN Customer ON BookSold.CustomerID = Customer.CustomerID