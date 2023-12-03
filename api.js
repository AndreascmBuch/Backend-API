// Configuration of the API server with connection to SQL
const express = require("express");
const mysql = require("mysql2");
const cors = require("cors");

const app = express();
const port = 3000;

app.use(cors());
app.use(express.json());

const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'Tipsbladet!1997',
    database: 'portfolio5'
});
connection.connect((err) => {
    if (err) {
        console.error('Error connecting to MySQL:', err);
        return;
    }
    console.log('Connected to MySQL');
});

app.get('/signin', (req, res) => {
    res.sendFile(__dirname + '/client/index.html');
});


/// Get statements to collect data for the client
app.get('/users',(req,res)=>{
    connection.query('SELECT * FROM users ',(error,results)=>{
        res.send(results);
    });
});

app.get('/users/:user_id',(req,res)=>{
    const userRequestForId = req.params.user_id
    connection.query('SELECT * FROM users where user_id =?;',[userRequestForId],(error,results)=>{
        res.send(results);
    });
});

app.get('/cafes',(req,res)=>{
    connection.query('SELECT * FROM cafes ',(error,results)=>{
        res.send(results);
    });
});

app.get('/cafes/:cafe_id',(req,res)=>{
    const userRequestForCafe = req.params.cafe_id
    connection.query('SELECT * FROM cafes where cafe_id =?;',[userRequestForCafe],(error,results)=>{
        res.send(results);
    });
});
app.get('/cafes/specific/:location',(req,res)=>{
    const userRequestForLocation = req.params.location
    connection.query('SELECT * FROM cafes where location =?;',[userRequestForLocation],(error,results)=>{
        res.send(results);
    });
});


// Post statement for the clint to send data to the server
app.post('/signin',(req,res)=>{
    const username = req.body.username;
    const password = req.body.password;
    console.log(username);
    console.log(password);
    connection.query('insert into users(username,password) values (?,?)', [username,password])
    res.send("Successful POST request");
});

app.post('/cafe/insert',(req,res)=>{
    const cafeName = req.body.cafe_name
    const location = req.body.location
    connection.query('insert into cafes(cafe_name,location) values (?,?)', [cafeName,location])
    res.send("Successful POST request");
});


// Post statement for favorits, do not work
app.post('/cafe/favorites', (req, res) => {
    const userId = req.body.user_id;
    const cafeId = req.body.cafe_id;
    connection.query('INSERT INTO favorites(user_id, cafe_id, cafe_name) SELECT user_id, cafes.id, cafes.cafe_name FROM cafes JOIN users ON cafes.user_id = users.user_id WHERE cafes.id = ? AND users.user_id = ?;', [userId, cafeId], (error, results) => {
        {
            res.send("Successful POST request");
        }
    });
});

app.listen(port,()=>{
    console.log("server now running on port"+port)
})