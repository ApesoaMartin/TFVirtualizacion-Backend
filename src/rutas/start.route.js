import {Router} from 'express';
import { about, getArticulos, ping} from '../controladores/start.controller.js';


const router = Router();

//router.get('/', indexPage)
router.get('/ping', ping);
router.get('/info/:cat', getArticulos);
//router.post('/addComment', submitComment);

export default router;