SELECT * FROM purchase.`purchase history`;
############################################################################################################
#QUESTION 2
CREATE TABLE Customer1 (Customer_Id VARCHAR(300));

INSERT INTO Customer1 VALUES('Abhinash'),('Vipin'),('Mahesh'),('Bijoy'),('Bhabani'),('Ashutosh');

CREATE TABLE Voucher (Voucher_Id VARCHAR(300) UNIQUE);

INSERT INTO Voucher VALUES('ABXFH'),('SDFGH'),('ERTYY'),('PPLKM');

WITH cte as(SELECT *,ROW_NUMBER() OVER(ORDER BY Customer_Id) rr FROM Customer1),cte2 
AS(SELECT *,ROW_NUMBER() OVER(ORDER BY Voucher_Id) rr FROM Voucher)
SELECT Customer_Id Customer_Key,Voucher_Id Gift_Voucher_Key FROM cte c1 LEFT JOIN cte2 c2 ON c1.rr=c2.rr;

##########################################################################################################

#QUESTION 1

SELECT Cat_Id,Product_Id,ROW_NUMBER() OVER(PARTITION BY Cat_Id) AS Trending
FROM (SELECT .Cat_Id,p.Product_Id,o.Sale_Qty,
         ROW_NUMBER() OVER (PARTITION BY p.Cat_Id ORDER BY o.Sale_Qty DESC) rn
  FROM product_catalogue p INNER JOIN purchase_history o
  ON o.Product_Id = p.Product_Id
  GROUP BY p.Product_Id
)
WHERE rn <= 2
ORDER BY Product_Id;

############################################################################################################
