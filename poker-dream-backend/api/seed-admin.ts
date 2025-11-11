import { PrismaClient } from '@prisma/client';
import bcrypt from 'bcrypt';

const prisma = new PrismaClient();

async function main() {
  console.log('Seeding admin user...');

  // Hash the password
  const password = 'admin123'; // Change this to a secure password
  const hashedPassword = await bcrypt.hash(password, 10);

  // Create or update admin user
  const admin = await prisma.user.upsert({
    where: { email: 'admin@pokerdream.com' },
    update: {},
    create: {
      email: 'admin@pokerdream.com',
      password: hashedPassword,
      name: 'Admin User',
      role: 'SUPER_ADMIN',
      isActive: true,
      emailVerified: true,
    },
  });

  console.log('Admin user created:');
  console.log('Email:', admin.email);
  console.log('Password:', password);
  console.log('Role:', admin.role);
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
