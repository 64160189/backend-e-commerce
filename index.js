//server

var express = require('express')
var ejs = require('ejs')
var bodyParser = require('body-parser')
var mysql = require('mysql')
var session = require('express-session')

const { connect } = require('http2')

/*mysql.createConnection({
    host: "localhost",
    user: 'root',
    password: "",
    database: "node_project1"
})*/

const connection = mysql.createConnection({
    host: "localhost",
    user: 'root',
    password: "",
    database: "node_project1"
})

connection.connect((error) => {
    if (error) {
        console.log('Error connecting to the database', error)
    } else {
        console.log('connect to database')
    }
})

var app = express()

app.use(express.static('public'));
app.set('view engine', 'ejs');
app.use(bodyParser.urlencoded({ express: true }));
app.use(session({ secret: "secret", resave: false, saveUninitialized: false, }));

const port = 3000;

function isProductsInCart(cart, id) {

    for (let i = 0; i < cart.length; i++) {
        if (cart[i].id == id) {
            return true;
        }
    }

    return false;
}

function calculateTotal(cart, req) {
    total = 0;

    for (let i = 0; i < cart.length; i++) {
        if (cart[i].sale_price) {
            total = total + (cart[i].sale_price * cart[i].quantity);
        } else {
            total = total + (cart[i].price * cart[i].quantity);
        }
    }
    req.session.total = total;
    return total;
}


app.get('/', function (req, res) {
    var con = mysql.createConnection({
        host: "localhost",
        user: 'root',
        password: "",
        database: "node_project1"
    })

    connection.query('SELECT * FROM products', (error, results) => {
        if (error) {
            console.error('Error fetching products: ', error)
            res.status(500).send('Internet Server Error');
        } else {
            res.render('pages/index', { products: results })
        }
    })
})



app.post('/add_to_cart', function (req, res) {
    var id = req.body.id;
    var name = req.body.name;
    var price = req.body.price;
    var sale_price = req.body.sale_price;
    var quantity = req.body.quantity;
    var image = req.body.image;
    var products = { id: id, name: name, price: price, sale_price: sale_price, quantity: quantity, image: image };

    if (req.session.cart) {
        var cart = req.session.cart;
        if (!isProductsInCart(cart, id)) {
            cart.push(products);
        }

    } else {
        req.session.cart = [products];
        var cart = req.session.cart;
    }

    //calculate total
    calculateTotal(cart, req);

    res.redirect('/cart');

})

app.get('/cart', function (req, res) {
    var cart = req.session.cart;
    var total = req.session.total;

    res.render('pages/cart', { cart: cart, total: total });
})

app.post('/remove_product', function (req, res) {
    var id = req.body.id;
    var cart = req.session.cart;

    for (let i = 0; i < cart.length; i++) {
        if (cart[i].id == id) {
            cart.splice(cart.indexOf(i), 1)
        }
    }

    calculateTotal(cart, req);
    res.redirect('/cart');
})

app.post('/edit_product_quantity', function (req, res) {
    var id = req.body.id;

    var increase_btn = req.body.increase_product_quantity;
    var decrease_btn = req.body.decrease_product_quantity;
    var cart = req.session.cart;

    for (let i = 0; i < cart.length; i++) {
        if (cart[i].id == id) {
            if (increase_btn) {
                if (cart[i].quantity > 0) {
                    cart[i].quantity += 1;
                }
            } else if (decrease_btn) {
                if (cart[i].quantity > 1) {
                    cart[i].quantity -= 1;
                }
            }
        }
    }

    calculateTotal(cart, req);
    res.redirect('/cart');
})

app.get('/checkout', function (req, res) {
    var total = req.session.total
    res.render('pages/checkout', { total: total })
})

app.post('/place_order', function (req, res) {
    var name = req.body.name;
    var email = req.body.email;
    var phone = req.body.phone;
    var city = req.body.city;
    var address = req.body.address;
    var cost = req.session.total;
    var status = "not paid";
    var date = new Date();
    var products_ids = "";

    const connection = mysql.createConnection({
        host: "localhost",
        user: 'root',
        password: "",
        database: "node_project1"
    })

    var cart = req.session.cart;
    for (let i = 0; i < cart.length; i++) {
        products_ids = products_ids + "," + cart[i].id;
    }

    connection.connect((error) => {
        if (error) {
            console.log('Error connecting to the database', error)
        } else {
            var query = "INSERT INTO orders(cost,name,email,status,city,address,phone,date,products_ids) VALUES ?";
            var values = [[cost, name, email, status, city, address, phone, date, products_ids]];

            connection.query(query, [values], (err, result) => {
                res.redirect('/payment')
            })
        }
    })


})

app.get('/payment', function (req, res) {
    res.render('pages/payment');
})



app.listen(port, () => {
    console.log(`http://localhost:${port}`);
})