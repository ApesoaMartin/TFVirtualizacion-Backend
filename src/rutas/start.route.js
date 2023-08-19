import {Router} from 'express';
import { about, ping} from '../controladores/start.controller.js';


const router = Router();

//router.get('/', indexPage)
router.get('/ping', ping);
router.get('/about', about);
//router.post('/addComment', submitComment);

export default router;