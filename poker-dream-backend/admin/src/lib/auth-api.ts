const API_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:4000/api';

export interface User {
  id: string;
  email: string;
  name: string | null;
  role: 'SUPER_ADMIN' | 'ADMIN' | 'EDITOR' | 'USER';
}

export interface LoginResponse {
  success: boolean;
  data: {
    accessToken: string;
    refreshToken: string;
    user: User;
  };
}

export const authApi = {
  async login(email: string, password: string): Promise<LoginResponse> {
    const response = await fetch(`${API_URL}/auth/login`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ email, password }),
    });

    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.error || 'Login failed');
    }

    return response.json();
  },

  async getMe(token: string): Promise<{ success: boolean; data: User }> {
    const response = await fetch(`${API_URL}/auth/me`, {
      headers: {
        'Authorization': `Bearer ${token}`,
      },
    });

    if (!response.ok) {
      throw new Error('Failed to fetch user');
    }

    return response.json();
  },

  async logout(token: string): Promise<void> {
    await fetch(`${API_URL}/auth/logout`, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${token}`,
      },
    });
  },
};
