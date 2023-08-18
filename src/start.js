import path from 'path';
import express from "express";
import {engine} from 'express-handlebars';
import { PORT } from "./config.js";
import start from './rutas/start.route.js'
import { fileURLToPath } from 'url';
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();

//Configuracion
app.use((req, res, next)=>{
    console.log(req.method, req.url);
    next();
});
app.set('port', PORT);
app.set('views', path.join(__dirname, 'views'));
app.engine('.hbs', engine({
    layoutsDir: path.join(app.get('views'), 'layouts'),
    partialsDir: path.join(app.get('views'), 'partials'),
    extname: '.hbs',
    defaultLayout: 'main'
}));
app.set('view engine', '.hbs');

//Middleware
//app.use(express.json());
app.use(express.urlencoded({extended:false}));

//Rutas
app.use(start);

//Extras
app.use(express.static("./node_modules/bootstrap/dist/"));
app.use(express.static(path.join(__dirname, 'public')));

//Error
app.use((req, res)=>{
    res.render("error");
})

app.listen(PORT);
console.log("Escuchando puerto", PORT);