import {Router} from 'express';
import { indexPage, ping, submitComment } from '../controladores/start.controller.js';


const router = Router();

router.get('/', indexPage)
router.get('/ping', ping);
router.post('/addComment', submitComment);

export default router;