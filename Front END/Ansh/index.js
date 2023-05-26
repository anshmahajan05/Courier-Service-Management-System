var express = require('express');
var session = require('express-session');
var mysql = require('mysql');
var bodyParser = require('body-parser');

var app = express();
app.set('view engine', 'ejs');
app.listen(5000);
console.log("App is listening on port 5000")
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static('public'));
app.use(session({ secret: "secret" }));

var mysql = require('mysql2');
var conn = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'courierdb'
});
conn.connect((err) => {
    if (err) {
        console.log(err)
        console.log("ERROR OCCURED")
        return
    }
    console.log('Database Connected')
})
module.exports = conn;



app.get('/', function(req, res) {
    res.render('admin')
})

app.post('/go_create', function(req, res) {

    console.log("sender")
    res.render('sender')

})

app.post('/create', function(req, res) {

    console.log("sender")
    res.render('sender')

})

app.post('/insert_sender', function(req, res) {
    var record = {
        s_id: req.body.sendno,
        name: req.body.sendname,
        email: req.body.email,
        phoneno: req.body.phone,
        street: req.body.street,
        city: req.body.city,
        state: req.body.state,
        country: req.body.country,
        pinCode: req.body.pin,
        a_id: req.body.admin
    }
    conn.query('INSERT INTO sender SET ?', record, function(error) {
        if (error) {
            console.log(error.message);
        } else {
            console.log('success');
        }
    });

    res.render('reciever')
})

app.post('/insert_reciever', function(req, res) {
    var record = {
        r_id: req.body.recno,
        name: req.body.recname,
        email: req.body.email,
        phoneno: req.body.phone,
        street: req.body.street,
        city: req.body.city,
        state: req.body.state,
        country: req.body.country,
        pinCode: req.body.pin,
        a_id: req.body.admin,
        s_id: req.body.sendno
    }
    conn.query('INSERT INTO reciever SET ?', record, function(error) {
        if (error) {
            console.log(error.message);
        } else {
            console.log('success');
        }
    });
    res.render('shipment')
})

app.post('/shipment', function(req, res) {
    console.log('Shipment started');
    var shipment_id = req.body.ship;
    var shipment_type = req.body.type;
    var curr_location = req.body.loc;
    var shipment = {
        shipment_id: shipment_id,
        shipment_type: shipment_type,
        curr_location: curr_location
    }

    conn.query('INSERT INTO shipment SET ?', shipment, function(error) {
        if (error) {
            console.log("ERROR");
            console.log(error.message);
        } else {
            console.log('success');
        }
    });
    res.render('courier');
})
app.post('/courier', function(req, res) {
    console.log('order_placement started');
    var c_id = req.body.cid;
    var date = req.body.date;
    var weight = req.body.weight;
    var s_id = req.body.sendno;
    var r_id = req.body.recno;
    var a_id = req.body.admin;
    var ship = req.body.ship;
    var order_record = {
        c_id: c_id,
        date: date,
        weight: weight,
        s_id: s_id,
        r_id: r_id,
        a_id: a_id,
        shipment_id: ship
    }

    conn.query('INSERT INTO courier SET ?', order_record, function(error) {
        if (error) {
            console.log("ERROR");
            console.log(error.message);
        } else {
            console.log('order success');
        }
    });
    res.render('bill');
})

app.post('/bill', function(req, res) {
    console.log('bill started');
    var c_id = req.body.cid;
    var s_id = req.body.sendno;
    var billno = req.body.billno;
    var cost = req.body.amt;
    var tax = req.body.tax;
    var record = {
        billno: billno,
        cost: cost,
        tax: tax,
        s_id: s_id,
        c_id: c_id
    }

    conn.query('INSERT INTO bill SET ?', record, function(error) {
        if (error) {
            console.log("ERROR");
            console.log(error.message);
        } else {
            console.log('success');
        }
    });
    res.render('index');
})


app.get('/go_retrieve', function(req, res) {
    conn.query('SELECT * FROM courier', function(error, data) {
        if (error) {
            console.log(error.message);
            res.render('display', { data })
        } else {
            console.log('print success');
            res.render('display', { data })
        }
    });
})

app.post('/go_update', function(req, res) {

    res.render('update');

})

app.post('/go_courier', function(req, res) {

    res.render('updateCourier');

})

app.post('/update_courier', function(req, res) {
    console.log('Update started');
    var c_id = req.body.c_id;
    var date = req.body.date;
    var weight = req.body.weight;
    var record = {
        date: date,
        weight: weight
    }

    conn.query('UPDATE courier SET ? where c_id= ?', [record, c_id], function(error) {
        if (error) {
            console.log("ERROR");
            console.log(error.message);
        } else {
            console.log('success');
        }
    });
    res.render('index');
})

app.post('/go_sender', function(req, res) {

    res.render('updateSender');

})

app.post('/update_sender', function(req, res) {
    var s_id = req.body.sendno;
    var record = {
        name: req.body.sendname,
        email: req.body.email,
        phoneno: req.body.phone,
        street: req.body.street,
        city: req.body.city,
        state: req.body.state,
        country: req.body.country,
        pinCode: req.body.pin,
        a_id: req.body.admin
    }

    conn.query('UPDATE sender SET ? where s_id= ?', [record, s_id], function(error) {
        if (error) {
            console.log("ERROR");
            console.log(error.message);
        } else {
            console.log('success');
        }
    });
    res.render('index');
})

app.post('/go_reciever', function(req, res) {

    res.render('updateReciever');

})

app.post('/update_reciever', function(req, res) {
    var r_id = req.body.recno;
    var record = {
        name: req.body.recname,
        email: req.body.email,
        phoneno: req.body.phone,
        street: req.body.street,
        city: req.body.city,
        state: req.body.state,
        country: req.body.country,
        pinCode: req.body.pin,
        a_id: req.body.admin,
        s_id: req.body.sendno
    }
    conn.query('UPDATE reciever SET ? where r_id= ?', [record, r_id], function(error) {
        if (error) {
            console.log(error.message);
        } else {
            console.log('success');
        }
    });
    res.render('index');
})

app.post('/go_shipment', function(req, res) {

    res.render('updateShipment');

})

app.post('/update_shipment', function(req, res) {
    console.log('Shipment updation started');
    var shipment_id = req.body.ship;
    var curr_location = req.body.loc;
    var shipment = {
        curr_location: curr_location
    }

    conn.query('UPDATE shipment SET ? where shipment_id = ?', [shipment, shipment_id], function(error) {
        if (error) {
            console.log("ERROR");
            console.log(error.message);
        } else {
            console.log('success');
        }
    });
    res.render('index');
})

app.post('/go_delete', function(req, res) {

    res.render('delete');

})

app.post('/delete_courier', function(req, res) {
    console.log('delete started');
    var c_id = req.body.c_id;

    conn.query('DELETE FROM courier where c_id= ?', c_id, function(error) {
        if (error) {
            console.log("ERROR");
            console.log(error.message);
        } else {
            console.log('success');
        }
    });
    res.render('index');
})

app.post('/go_track', function(req, res) {

    res.render('track');

})

app.post('/track', function(req, res) {
    console.log('tracking started');
    var c_id = req.body.cid;
    console.log(c_id);
    conn.query('SELECT c_id,sender.name as sender_name,reciever.name as reciever_name,reciever.street,reciever.city,reciever.state,reciever.country,reciever.pinCode,shipment.curr_location FROM courier INNER JOIN sender ON courier.s_id=sender.s_id INNER JOIN reciever ON courier.r_id=reciever.r_id INNER JOIN shipment ON courier.shipment_id=shipment.shipment_id where c_id= ?', c_id, function(error, data) {
        if (error) {
            console.log("ERROR");
            console.log(error.message);
            res.render('tracking', { data });
        } else {
            console.log('success');
            res.render('tracking', { data });
        }
    });
})

app.post('/back', function(req, res) {

    res.render('index');

})

app.post('/go_user', function(req, res) {

    res.render('login');

})

app.post('/login', function(req, res) {

    res.render('user');

})

app.post('/go_track_all', function(req, res) {
    console.log('all tracking started');
    conn.query('call proc', function(error, data) {
        if (error) {
            console.log("ERROR");
            console.log(error.message);
            res.render('tracking_all', { data });
        } else {
            console.log('success');
            conn.query('Select * from t1', function(err, data) {
                console.log("SUCCESS");
                res.render('tracking_all', { data });
            })
        }
    });
})

app.post('/back', function(req, res) {

    res.render('index');

})

app.post('/admin', function(req, res) {
    res.render('index')
})