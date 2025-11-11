'use client';

import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { z } from 'zod';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
import { ImageUpload } from '@/components/ui/image-upload';
import { Tournament } from '@/lib/api';

const tournamentFormSchema = z.object({
  name: z.string().min(3, 'Name must be at least 3 characters'),
  description: z.string().optional(),
  startDate: z.string().optional(),
  endDate: z.string().optional(),
  location: z.string().optional(),
  venue: z.string().optional(),
  status: z.enum(['UPCOMING', 'LIVE', 'COMPLETED', 'CANCELLED']),
  prizePool: z.string().optional(),
  buyIn: z.string().optional(),
  totalEntries: z.string().optional(),
  bannerImageUrl: z.string().optional(),
});

type TournamentFormData = z.infer<typeof tournamentFormSchema>;

interface TournamentFormProps {
  tournament?: Tournament;
  onSubmit: (data: Partial<Tournament>) => Promise<void>;
  onCancel: () => void;
  isLoading?: boolean;
}

export function TournamentForm({
  tournament,
  onSubmit,
  onCancel,
  isLoading = false,
}: TournamentFormProps) {
  const {
    register,
    handleSubmit,
    setValue,
    watch,
    formState: { errors },
  } = useForm<TournamentFormData>({
    resolver: zodResolver(tournamentFormSchema),
    defaultValues: {
      name: tournament?.name || '',
      description: tournament?.description || '',
      startDate: tournament?.startDate
        ? new Date(tournament.startDate).toISOString().slice(0, 16)
        : '',
      endDate: tournament?.endDate
        ? new Date(tournament.endDate).toISOString().slice(0, 16)
        : '',
      location: tournament?.location || '',
      venue: tournament?.venue || '',
      status: tournament?.status || 'UPCOMING',
      prizePool: tournament?.prizePool?.toString() || '',
      buyIn: tournament?.buyIn?.toString() || '',
      totalEntries: tournament?.totalEntries?.toString() || '0',
      bannerImageUrl: tournament?.bannerImageUrl || '',
    },
  });

  const statusValue = watch('status');
  const bannerImageUrl = watch('bannerImageUrl');

  const onSubmitForm = async (data: TournamentFormData) => {
    const formattedData: Partial<Tournament> = {
      name: data.name,
      description: data.description || undefined,
      startDate: data.startDate ? new Date(data.startDate).toISOString() : undefined,
      endDate: data.endDate ? new Date(data.endDate).toISOString() : undefined,
      location: data.location || undefined,
      venue: data.venue || undefined,
      status: data.status,
      prizePool: data.prizePool ? parseFloat(data.prizePool) : undefined,
      buyIn: data.buyIn ? parseFloat(data.buyIn) : undefined,
      totalEntries: data.totalEntries ? parseInt(data.totalEntries, 10) : 0,
      bannerImageUrl: data.bannerImageUrl || undefined,
    };

    await onSubmit(formattedData);
  };

  return (
    <form onSubmit={handleSubmit(onSubmitForm)} className="space-y-6">
      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        {/* Name */}
        <div className="space-y-2">
          <Label htmlFor="name">
            Tournament Name <span className="text-red-500">*</span>
          </Label>
          <Input
            id="name"
            {...register('name')}
            placeholder="Enter tournament name"
            disabled={isLoading}
          />
          {errors.name && (
            <p className="text-sm text-red-500">{errors.name.message}</p>
          )}
        </div>

        {/* Status */}
        <div className="space-y-2">
          <Label htmlFor="status">
            Status <span className="text-red-500">*</span>
          </Label>
          <Select
            value={statusValue}
            onValueChange={(value) =>
              setValue('status', value as TournamentFormData['status'])
            }
            disabled={isLoading}
          >
            <SelectTrigger>
              <SelectValue placeholder="Select status" />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="UPCOMING">Upcoming</SelectItem>
              <SelectItem value="LIVE">Live</SelectItem>
              <SelectItem value="COMPLETED">Completed</SelectItem>
              <SelectItem value="CANCELLED">Cancelled</SelectItem>
            </SelectContent>
          </Select>
          {errors.status && (
            <p className="text-sm text-red-500">{errors.status.message}</p>
          )}
        </div>

        {/* Start Date */}
        <div className="space-y-2">
          <Label htmlFor="startDate">Start Date</Label>
          <Input
            id="startDate"
            type="datetime-local"
            {...register('startDate')}
            disabled={isLoading}
          />
          {errors.startDate && (
            <p className="text-sm text-red-500">{errors.startDate.message}</p>
          )}
        </div>

        {/* End Date */}
        <div className="space-y-2">
          <Label htmlFor="endDate">End Date</Label>
          <Input
            id="endDate"
            type="datetime-local"
            {...register('endDate')}
            disabled={isLoading}
          />
          {errors.endDate && (
            <p className="text-sm text-red-500">{errors.endDate.message}</p>
          )}
        </div>

        {/* Location */}
        <div className="space-y-2">
          <Label htmlFor="location">Location</Label>
          <Input
            id="location"
            {...register('location')}
            placeholder="e.g., Las Vegas, NV"
            disabled={isLoading}
          />
          {errors.location && (
            <p className="text-sm text-red-500">{errors.location.message}</p>
          )}
        </div>

        {/* Venue */}
        <div className="space-y-2">
          <Label htmlFor="venue">Venue</Label>
          <Input
            id="venue"
            {...register('venue')}
            placeholder="e.g., Aria Resort & Casino"
            disabled={isLoading}
          />
          {errors.venue && (
            <p className="text-sm text-red-500">{errors.venue.message}</p>
          )}
        </div>

        {/* Prize Pool */}
        <div className="space-y-2">
          <Label htmlFor="prizePool">Prize Pool ($)</Label>
          <Input
            id="prizePool"
            type="number"
            step="0.01"
            {...register('prizePool')}
            placeholder="10000000"
            disabled={isLoading}
          />
          {errors.prizePool && (
            <p className="text-sm text-red-500">{errors.prizePool.message}</p>
          )}
        </div>

        {/* Buy-in */}
        <div className="space-y-2">
          <Label htmlFor="buyIn">Buy-in ($)</Label>
          <Input
            id="buyIn"
            type="number"
            step="0.01"
            {...register('buyIn')}
            placeholder="10000"
            disabled={isLoading}
          />
          {errors.buyIn && (
            <p className="text-sm text-red-500">{errors.buyIn.message}</p>
          )}
        </div>

        {/* Total Entries */}
        <div className="space-y-2">
          <Label htmlFor="totalEntries">Total Entries</Label>
          <Input
            id="totalEntries"
            type="number"
            {...register('totalEntries')}
            placeholder="0"
            disabled={isLoading}
          />
          {errors.totalEntries && (
            <p className="text-sm text-red-500">
              {errors.totalEntries.message}
            </p>
          )}
        </div>

        {/* Banner Image Upload */}
        <div className="space-y-4 md:col-span-2">
          <ImageUpload
            value={bannerImageUrl}
            onChange={(url) => setValue('bannerImageUrl', url)}
            label="Banner Image"
            disabled={isLoading}
          />

          {/* Optional: Manual URL Input */}
          <div className="space-y-2">
            <Label htmlFor="bannerImageUrl" className="text-sm text-muted-foreground">
              Or enter image URL manually
            </Label>
            <Input
              id="bannerImageUrl"
              {...register('bannerImageUrl')}
              placeholder="https://example.com/image.jpg"
              disabled={isLoading}
            />
            {errors.bannerImageUrl && (
              <p className="text-sm text-destructive">
                {errors.bannerImageUrl.message}
              </p>
            )}
          </div>
        </div>
      </div>

      {/* Description */}
      <div className="space-y-2">
        <Label htmlFor="description">Description</Label>
        <Textarea
          id="description"
          {...register('description')}
          placeholder="Enter tournament description"
          rows={4}
          disabled={isLoading}
        />
        {errors.description && (
          <p className="text-sm text-red-500">{errors.description.message}</p>
        )}
      </div>

      {/* Action Buttons */}
      <div className="flex justify-end space-x-4">
        <Button
          type="button"
          variant="outline"
          onClick={onCancel}
          disabled={isLoading}
        >
          Cancel
        </Button>
        <Button type="submit" disabled={isLoading}>
          {isLoading ? 'Saving...' : tournament ? 'Update' : 'Create'}
        </Button>
      </div>
    </form>
  );
}
