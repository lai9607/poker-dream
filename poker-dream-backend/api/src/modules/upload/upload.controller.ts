import { Request, Response } from 'express';
import path from 'path';
import fs from 'fs';

export class UploadController {
  async uploadImage(req: Request, res: Response) {
    try {
      if (!req.file) {
        return res.status(400).json({ error: 'No file uploaded' });
      }

      // Generate URL for the uploaded file
      const imageUrl = `${req.protocol}://${req.get('host')}/uploads/${req.file.filename}`;

      res.status(200).json({
        message: 'Image uploaded successfully',
        imageUrl,
        filename: req.file.filename,
      });
    } catch (error) {
      console.error('Upload error:', error);
      res.status(500).json({ error: 'Failed to upload image' });
    }
  }

  async deleteImage(req: Request, res: Response) {
    try {
      const { filename } = req.params;
      const filePath = path.join(process.cwd(), 'uploads', filename);

      // Check if file exists
      if (fs.existsSync(filePath)) {
        fs.unlinkSync(filePath);
        res.status(200).json({ message: 'Image deleted successfully' });
      } else {
        res.status(404).json({ error: 'Image not found' });
      }
    } catch (error) {
      console.error('Delete error:', error);
      res.status(500).json({ error: 'Failed to delete image' });
    }
  }
}
