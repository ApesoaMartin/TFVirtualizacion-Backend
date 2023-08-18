import {pool} from '../db.js';
import { getComments, addComment } from './commentsController.js';

export const ping = async (req, res) => {
    try{
        const [result] = await pool.query('SELECT "Pong" AS result');
        res.json(result[0].result);
    }
    catch (err){
        console.log(err);
        res.send(err);
    }
};

export const indexPage = async (req, res)=>{
    const [comments] = await getComments();
    res.render("index", {comments});
};

export const submitComment = async(req, res)=>{
    const {nombre, texto} = req.body;
    if (nombre && texto){
        console.log("Comentando: ", nombre, texto);
        addComment(nombre, texto);
    }else {
        res.status(500);
    }
    res.redirect("/");
}