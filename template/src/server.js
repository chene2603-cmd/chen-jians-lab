import express from 'express';
import { securityMiddleware } from './middleware/security.js';
const app = express();
app.use(express.json());
app.use(securityMiddleware);

app.get('/health', (req, res) => res.send('OK'));
app.post('/simulate', (req, res) => {
  res.json({ status: 'simulation started', params: req.body });
});

app.listen(3000, () => console.log('ColdAtomDigitalTwin running on :3000'));