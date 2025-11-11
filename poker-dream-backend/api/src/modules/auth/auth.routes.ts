import { Router } from 'express';
import { authController } from './auth.controller';
import { authenticate } from '../../middleware/auth';

const router = Router();

router.post('/register', authController.register.bind(authController));
router.post('/login', authController.login.bind(authController));
router.post('/refresh', authController.refreshToken.bind(authController));
router.post('/logout', authenticate, authController.logout.bind(authController));
router.get('/me', authenticate, authController.getMe.bind(authController));

export default router;
