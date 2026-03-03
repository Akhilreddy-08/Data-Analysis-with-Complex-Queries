SELECT Title, Genre, Price,
       RANK() OVER (PARTITION BY Genre ORDER BY Price DESC) as Price_Rank
FROM Books;

WITH CustomerRevenue AS (
    SELECT c.Name, SUM(b.Price * o.Quantity) as Total_Spent
    FROM Customers c
    JOIN Orders o ON c.Customer_ID = o.Customer_ID
    JOIN Books b ON o.Book_ID = b.Book_ID
    GROUP BY c.Name
)
SELECT * FROM CustomerRevenue WHERE Total_Spent > 100 ORDER BY Total_Spent DESC;

SELECT Title, Price, Genre
FROM Books
WHERE Price > (SELECT AVG(Price) FROM Books);