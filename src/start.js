import path from 'path';
import cors from 'cors'
import express from "express";
import {engine} from 'express-handlebars';
import { PORT } from "./config.js";
import start from './rutas/start.route.js'
import { fileURLToPath } from 'url';
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();

//Configuracion
app.use(cors());
app.use((req, res, next)=>{
    console.log(req.method, req.url);
    next();
});

app.use(start);

app.listen(PORT);
console.log("Escuchando puerto", PORT);