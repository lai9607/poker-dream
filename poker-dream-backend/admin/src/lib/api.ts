import axios from 'axios';

const API_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3001/api';

export const api = axios.create({
  baseURL: API_URL,
  headers: {
    'Content-Type': 'application/json',
  },
  withCredentials: true,
});

// Request interceptor to add auth token
api.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem('accessToken');
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

// Response interceptor for token refresh
api.interceptors.response.use(
  (response) => response,
  async (error) => {
    const originalRequest = error.config;

    if (error.response?.status === 401 && !originalRequest._retry) {
      originalRequest._retry = true;

      try {
        const refreshToken = localStorage.getItem('refreshToken');
        const response = await axios.post(`${API_URL}/auth/refresh`, {
          refreshToken,
        });

        const { accessToken } = response.data;
        localStorage.setItem('accessToken', accessToken);

        originalRequest.headers.Authorization = `Bearer ${accessToken}`;
        return api(originalRequest);
      } catch (refreshError) {
        localStorage.removeItem('accessToken');
        localStorage.removeItem('refreshToken');
        window.location.href = '/login';
        return Promise.reject(refreshError);
      }
    }

    return Promise.reject(error);
  }
);

// Tournament API calls
export interface Tournament {
  id: string;
  name: string;
  description?: string;
  startDate?: string;
  endDate?: string;
  location?: string;
  venue?: string;
  status: 'UPCOMING' | 'LIVE' | 'COMPLETED' | 'CANCELLED';
  prizePool?: number;
  buyIn?: number;
  totalEntries: number;
  bannerImageUrl?: string;
  createdAt: string;
  updatedAt: string;
}

export interface TournamentQuery {
  status?: 'UPCOMING' | 'LIVE' | 'COMPLETED' | 'CANCELLED';
  page?: number;
  limit?: number;
  search?: string;
}

export interface PaginatedResponse<T> {
  data: T[];
  pagination: {
    page: number;
    limit: number;
    total: number;
    totalPages: number;
  };
}

export const tournamentsApi = {
  getAll: (query?: TournamentQuery) =>
    api.get<PaginatedResponse<Tournament>>('/tournaments', { params: query }),

  getById: (id: string) =>
    api.get<{ data: Tournament }>(`/tournaments/${id}`),

  create: (data: Partial<Tournament>) =>
    api.post<{ message: string; data: Tournament }>('/tournaments', data),

  update: (id: string, data: Partial<Tournament>) =>
    api.put<{ message: string; data: Tournament }>(`/tournaments/${id}`, data),

  delete: (id: string) =>
    api.delete<{ message: string }>(`/tournaments/${id}`),

  getUpcoming: (limit?: number) =>
    api.get<{ data: Tournament[] }>('/tournaments/upcoming', {
      params: { limit },
    }),

  getLive: () =>
    api.get<{ data: Tournament[] }>('/tournaments/live'),

  getStats: () =>
    api.get<{
      data: {
        total: number;
        upcoming: number;
        live: number;
        completed: number;
      };
    }>('/tournaments/stats'),
};

// Auth API calls
export interface LoginCredentials {
  email: string;
  password: string;
}

export interface RegisterData {
  email: string;
  password: string;
  name?: string;
}

export interface User {
  id: string;
  email: string;
  name?: string;
  role: string;
  isActive: boolean;
}

export const authApi = {
  login: (credentials: LoginCredentials) =>
    api.post<{
      message: string;
      accessToken: string;
      refreshToken: string;
      user: User;
    }>('/auth/login', credentials),

  register: (data: RegisterData) =>
    api.post<{
      message: string;
      accessToken: string;
      refreshToken: string;
      user: User;
    }>('/auth/register', data),

  getMe: () =>
    api.get<{ data: User }>('/auth/me'),

  refreshToken: (refreshToken: string) =>
    api.post<{ accessToken: string }>('/auth/refresh', { refreshToken }),
};
