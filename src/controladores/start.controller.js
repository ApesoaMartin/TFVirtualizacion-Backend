import { pool } from '../db.js';
import { CAT_About } from '../config.js';

export const ping = async (req, res) => {
    try {
        const [result] = await pool.query('SELECT "Pong" AS result');
        res.json(result[0].result);
    }
    catch (err) {
        console.log(err);
        res.send(err);
    }
};

function procesarContenido(contenido){
    if (contenido.cuerpo.startsWith("{")){
        let sep = contenido.cuerpo.indexOf(" ");
        let cmd = contenido.cuerpo.substring(1, sep);
        let arg = contenido.cuerpo.substring(sep+1, contenido.cuerpo.length-1);
        
        switch (cmd){
            case "img":
                contenido.cuerpo='<img class="'+contenido.clase+'" src="/resources/'+arg+'"/>';
                break;
            case "list":
                const valores = arg.split(",");
                contenido.cuerpo='<ul class="list-group">';
                for (let i=0; i<valores.length; i++){
                    contenido.cuerpo+='<li class="list-group-item">'+valores[i]+'</li>';
                }
                contenido.cuerpo+='</ul>';
                break;
            default:
                contenido.cuerpo='';
                console.log("Unknown command "+cmd);
                break;
        }
    }
}

export const getArticulos = async (req, res) => {
    try {
        const [cats] = await pool.query('SELECT * FROM Categoria WHERE nombre="' + req.params.cat+'"');
        //console.log(cats[0]);
        const id = cats[0].id;
        const [rows] = await pool.query('SELECT * FROM Articulo WHERE categoria=' + id +' ORDER BY fecha DESC');
        //console.log(rows.length);
        let result = {articulos:[]};
        for (let i=0; i<rows.length; i++){
            let articulo = rows[i];
            result.articulos[i] = {
                titulo: articulo.titulo,
                contenido: [],
                link: articulo.link,
                linkDisplay: articulo.linkDisplay ?? articulo.link
            };
            const [contentRows] = await pool.query('SELECT * FROM Contenido WHERE idArticulo=' + articulo.id+' ORDER BY orden ASC');
            for (let j=0; j<contentRows.length; j++){
                procesarContenido(contentRows[j]);
            }
            //console.log(contentRows);
            result.articulos[i].contenido = contentRows;
        }
        //console.log(result);
        res.json(result);
    }
    catch (err) {
        console.log(err);
        res.send(err);
    }
};

export const about = async (req, res) => {
    try {
        const [rows] = await pool.query('SELECT * FROM Articulo WHERE categoria=' + CAT_About);
        const articulo = rows[0];
        const [contentRows] = await pool.query('SELECT * FROM Contenido WHERE idArticulo=' + articulo.id);
        const desc = contentRows[0];
        console.log(articulo);
        console.log(desc);
        res.json({
            titulo: articulo.titulo,
            cuerpo: desc.cuerpo,
            link: desc.link,
            linkDisplay: desc.linkDisplay ?? desc.link
        });
    }
    catch (err) {
        console.log(err);
        res.send(err);
    }
};