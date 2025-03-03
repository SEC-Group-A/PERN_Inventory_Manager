To register = 'INSERT INTO users (username, email , password) VALUES ($1, $2 , $3) RETURNING userid'; 

login = 'SELECT  userid FROM users WHERE email = $1 AND password = $2';

add product= 'INSERT INTO product (userid , name, price, quantity, quantitySold ,  company, photo) VALUES ($1, $2, $3, $4,0, $5 , $6) RETURNING *';

product list = pool.query('SELECT productid, name, price , quantity, company , photo FROM product where userid = $1' , [userId]);

delete products = 'DELETE FROM product WHERE productid = $1'

GET ONE product = "SELECT * FROM product WHERE productid = $1" , [id]);

update product = 'UPDATE product SET name = $1, price = $2, quantity = $3 , company = $4 WHERE productid = $5';

search products = `SELECT  name , price , quantity ,company , photo  FROM product WHERE (name ILIKE $1 OR CAST(price AS VARCHAR(20)) ILIKE $1 OR CAST(quantity AS VARCHAR(10)) ILIKE $1 OR company ILIKE $1) AND userid = $2`,
      [`%${key}%`, userId]

select profile = "SELECT username , email FROM users WHERE userid = $1" , [userId])

count products = "SELECT SUM(quantity) AS totalcount , SUM( price * quantity ) AS totalprice FROM product WHERE userid=$1",[userId])

/Add buyer = "INSERT INTO buyer (userid , name , bemail, address ) VALUES($1 , $2 , $3 , $4  ) RETURNING * " 

ADD productid to cart corresponding to buyerId = "INSERT INTO CART (buyer_id , product_id) VALUES($1 , $2) RETURNING *"

Show buyer's details = "SELECT * FROM buyer WHERE buyerid = $1" 

Show cart i.e. products bought by the buyer = SELECT product.name AS productname, product.company, product.quantitySold ,  (product.price * product.quantitySold) AS productPrice
    FROM buyer
    JOIN cart ON buyer.buyerid = cart.buyer_id
    JOIN product ON cart.product_id = product.productid
    WHERE buyer.buyerid = $1
  `;

Show total price of the products bought by buyer = SELECT SUM(product.price * product.quantitysold) AS total_price
    FROM buyer
    JOIN cart ON buyer.buyerid = cart.buyer_id
    JOIN product ON cart.product_id = product.productid
    WHERE buyer.buyerid = $1

Show buyer name  and products he bought and price = SELECT buyer.name AS buyer_name, ARRAY_AGG(product.name) AS product_names, ARRAY_AGG(product.quantitysold) AS quantities_sold, SUM(product.price * product.quantitysold) AS total_price
      FROM buyer
      INNER JOIN cart ON buyer.buyerid = cart.buyer_id
      INNER JOIN product ON cart.product_id = product.productid
      WHERE buyer.userid = $1
      GROUP BY buyer.buyerid, buyer.name

ADD QUANTITY SOLD IN PRODUCT TABLE/ = "UPDATE product SET quantitySold = $1 WHERE productid = $2", [quantitySold,productid]);
      const updateQuantityQuery =await pool.query( "UPDATE product SET quantity = quantity - $1 WHERE productid = $2" , [quantitySold , productid]);