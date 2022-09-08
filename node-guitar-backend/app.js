const express = require('express')
const cors = require('cors')
const app = express()
const routes = require('./controllers')
const port = process.env.PORT || 3000
const mongoose = require('mongoose');

app.use(cors())
app.use(express.urlencoded({extended: true}));
app.use(express.json());
app.use('/api',routes)


app.listen(port, () => {
    console.log(`Guitar Backend UP on ${port}`)
    mongoose.connect("mongodb+srv://dbadmin:BdhO7azKO7cxQgGP@guitarra.jec37.mongodb.net/guitarra?retryWrites=true&w=majority").then(r => console.log("Database Connected"));
})
