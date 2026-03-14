import path from 'path';
const MAX_TIMESTEPS = parseInt(process.env.MAX_TIMESTEPS, 10) || 1000000;

export function securityMiddleware(req, res, next) {
  const token = req.headers.authorization?.replace(/^Bearer\s+/i, '');
  if (token !== process.env.API_TOKEN) {
    return res.status(401).send('Unauthorized');
  }

  const timesteps = parseInt(req.body.timesteps || '0', 10);
  if (timesteps > MAX_TIMESTEPS) {
    return res.status(400).send(`timesteps 不能超过 ${MAX_TIMESTEPS}`);
  }

  if (req.body.filename) {
    const valid = /^[\w\-]+\.zip$/;
    if (!valid.test(req.body.filename)) {
      return res.status(400).send('非法文件名');
    }
    const uploadDir = path.resolve('./uploads');
    const filePath = path.resolve(path.join(uploadDir, req.body.filename));
    if (!filePath.startsWith(uploadDir)) {
      return res.status(403).send('非法路径');
    }
    req.filePath = filePath;
  }

  next();
}