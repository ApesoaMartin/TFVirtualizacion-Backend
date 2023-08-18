import {pool} from '../db.js';

//SELECT * FROM Comentarios WHERE parentID IS NULL
export const getComments = async () => {
    try{
        const rows = await pool.query('SELECT nombre, texto, DATE_FORMAT(fecha, "%H:%i - %d/%m/%Y") as date, parentID FROM Comentarios WHERE parentID IS NULL ORDER BY fecha DESC');
        if (rows==null) return [null];
        if (rows.length==0) return [[]];
        rows.forEach(x => {
            x.children = getReplies(x.id);
        });
        return rows;
    }
    catch (err){
        console.log(err);
        return [null];
    }
}

export const addComment = async (nombre, texto) => {
    try{
        const rows = await pool.query('INSERT INTO Comentarios (nombre, texto, fecha, parentID) VALUES (?, ?, NOW(), NULL)', [nombre, texto]);
        return true;
    }catch (err){
        console.log(err);
        return false;
    }
}

const getReplies = async (id) => {
    try{
        const rows = await pool.query('SELECT * FROM Comentarios WHERE parentID=?', [id]);
        if (rows.length==0)
            return null;
        return rows;
    }
    catch (err){
        console.log(err);
        return null;
    }
}