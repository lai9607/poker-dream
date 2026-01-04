"use client";

import { useState } from "react";
import { Metadata } from "next";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { z } from "zod";
import {
  Mail,
  Phone,
  MapPin,
  Clock,
  Send,
  Facebook,
  Instagram,
  Twitter,
  Youtube,
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { Input, Textarea } from "@/components/ui/input";
import { siteConfig } from "@/config/navigation";

const contactSchema = z.object({
  name: z.string().min(2, "Name must be at least 2 characters"),
  email: z.string().email("Invalid email address"),
  phone: z.string().optional(),
  subject: z.string().min(5, "Subject must be at least 5 characters"),
  type: z.enum(["GENERAL", "PARTNERSHIP", "MEDIA", "SUPPORT"]),
  message: z.string().min(20, "Message must be at least 20 characters"),
});

type ContactFormData = z.infer<typeof contactSchema>;

const contactTypes = [
  { value: "GENERAL", label: "General Inquiry" },
  { value: "PARTNERSHIP", label: "Partnership" },
  { value: "MEDIA", label: "Media & Press" },
  { value: "SUPPORT", label: "Support" },
];

const socialLinks = [
  { icon: Facebook, href: "https://facebook.com/pokerdream", label: "Facebook" },
  { icon: Instagram, href: "https://instagram.com/pokerdream", label: "Instagram" },
  { icon: Twitter, href: "https://twitter.com/pokerdream", label: "Twitter" },
  { icon: Youtube, href: "https://youtube.com/pokerdream", label: "YouTube" },
];

export default function ContactPage() {
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [isSuccess, setIsSuccess] = useState(false);

  const {
    register,
    handleSubmit,
    formState: { errors },
    reset,
  } = useForm<ContactFormData>({
    resolver: zodResolver(contactSchema),
    defaultValues: {
      type: "GENERAL",
    },
  });

  const onSubmit = async (data: ContactFormData) => {
    setIsSubmitting(true);
    // Simulate API call
    await new Promise((resolve) => setTimeout(resolve, 1500));
    console.log("Form submitted:", data);
    setIsSubmitting(false);
    setIsSuccess(true);
    reset();
    setTimeout(() => setIsSuccess(false), 5000);
  };

  return (
    <div style={{ paddingTop: "80px" }}>
      {/* Hero Section */}
      <section className="py-16 bg-[var(--background-secondary)]">
        <div className="container">
          <div className="max-w-2xl">
            <span className="inline-block px-4 py-2 mb-6 text-sm font-semibold text-[var(--gold)] bg-[var(--gold)]/10 rounded-full border border-[var(--gold)]/30">
              Get in Touch
            </span>
            <h1 className="text-4xl md:text-5xl font-bold mb-4">Contact Us</h1>
            <p className="text-xl text-[var(--foreground-secondary)]">
              Have questions about our tournaments? Interested in partnerships?
              We&apos;d love to hear from you.
            </p>
          </div>
        </div>
      </section>

      {/* Contact Content */}
      <section className="py-16">
        <div className="container">
          <div className="grid lg:grid-cols-3 gap-12">
            {/* Contact Info */}
            <div className="lg:col-span-1 space-y-8">
              <div>
                <h2 className="text-2xl font-bold mb-6">Contact Information</h2>
                <div className="space-y-6">
                  <div className="flex items-start gap-4">
                    <div className="w-12 h-12 rounded-lg bg-[var(--primary)]/10 flex items-center justify-center flex-shrink-0">
                      <Mail className="w-5 h-5 text-[var(--primary)]" />
                    </div>
                    <div>
                      <p className="font-medium mb-1">Email</p>
                      <a
                        href={`mailto:${siteConfig.email}`}
                        className="text-[var(--foreground-secondary)] hover:text-[var(--primary)]"
                      >
                        {siteConfig.email}
                      </a>
                    </div>
                  </div>

                  <div className="flex items-start gap-4">
                    <div className="w-12 h-12 rounded-lg bg-[var(--primary)]/10 flex items-center justify-center flex-shrink-0">
                      <Phone className="w-5 h-5 text-[var(--primary)]" />
                    </div>
                    <div>
                      <p className="font-medium mb-1">Phone</p>
                      <a
                        href={`tel:${siteConfig.phone}`}
                        className="text-[var(--foreground-secondary)] hover:text-[var(--primary)]"
                      >
                        {siteConfig.phone}
                      </a>
                    </div>
                  </div>

                  <div className="flex items-start gap-4">
                    <div className="w-12 h-12 rounded-lg bg-[var(--primary)]/10 flex items-center justify-center flex-shrink-0">
                      <MapPin className="w-5 h-5 text-[var(--primary)]" />
                    </div>
                    <div>
                      <p className="font-medium mb-1">Address</p>
                      <p className="text-[var(--foreground-secondary)]">
                        {siteConfig.address.line1}
                        <br />
                        {siteConfig.address.line2}
                        <br />
                        {siteConfig.address.city}, {siteConfig.address.country}
                      </p>
                    </div>
                  </div>

                  <div className="flex items-start gap-4">
                    <div className="w-12 h-12 rounded-lg bg-[var(--primary)]/10 flex items-center justify-center flex-shrink-0">
                      <Clock className="w-5 h-5 text-[var(--primary)]" />
                    </div>
                    <div>
                      <p className="font-medium mb-1">Business Hours</p>
                      <p className="text-[var(--foreground-secondary)]">
                        Monday - Friday: 9:00 AM - 6:00 PM
                        <br />
                        Saturday: 10:00 AM - 4:00 PM
                      </p>
                    </div>
                  </div>
                </div>
              </div>

              {/* Social Links */}
              <div>
                <h3 className="font-bold mb-4">Follow Us</h3>
                <div className="flex gap-3">
                  {socialLinks.map((social) => (
                    <a
                      key={social.label}
                      href={social.href}
                      target="_blank"
                      rel="noopener noreferrer"
                      className="w-10 h-10 rounded-full bg-[var(--surface)] flex items-center justify-center text-[var(--foreground-secondary)] hover:bg-[var(--primary)] hover:text-white transition-colors"
                      aria-label={social.label}
                    >
                      <social.icon className="w-5 h-5" />
                    </a>
                  ))}
                </div>
              </div>
            </div>

            {/* Contact Form */}
            <div className="lg:col-span-2">
              <div className="bg-[var(--surface)] rounded-2xl p-8 border border-[var(--border)]">
                <h2 className="text-2xl font-bold mb-6">Send Us a Message</h2>

                {isSuccess && (
                  <div className="mb-6 p-4 bg-[var(--success)]/10 border border-[var(--success)]/30 rounded-lg text-[var(--success)]">
                    Thank you for your message! We&apos;ll get back to you soon.
                  </div>
                )}

                <form onSubmit={handleSubmit(onSubmit)} className="space-y-6">
                  <div className="grid md:grid-cols-2 gap-6">
                    <Input
                      label="Your Name"
                      placeholder="John Doe"
                      error={errors.name?.message}
                      {...register("name")}
                    />
                    <Input
                      label="Email Address"
                      type="email"
                      placeholder="john@example.com"
                      error={errors.email?.message}
                      {...register("email")}
                    />
                  </div>

                  <div className="grid md:grid-cols-2 gap-6">
                    <Input
                      label="Phone Number (Optional)"
                      type="tel"
                      placeholder="+60 12-345-6789"
                      {...register("phone")}
                    />
                    <div>
                      <label className="block text-sm font-medium text-[var(--foreground-secondary)] mb-2">
                        Inquiry Type
                      </label>
                      <select
                        {...register("type")}
                        className="w-full px-4 py-3 rounded-lg bg-[var(--background)] border border-[var(--border)] text-[var(--foreground)] focus:outline-none focus:ring-2 focus:ring-[var(--primary)]"
                      >
                        {contactTypes.map((type) => (
                          <option key={type.value} value={type.value}>
                            {type.label}
                          </option>
                        ))}
                      </select>
                    </div>
                  </div>

                  <Input
                    label="Subject"
                    placeholder="How can we help you?"
                    error={errors.subject?.message}
                    {...register("subject")}
                  />

                  <Textarea
                    label="Message"
                    placeholder="Tell us more about your inquiry..."
                    error={errors.message?.message}
                    {...register("message")}
                  />

                  <Button
                    type="submit"
                    size="lg"
                    isLoading={isSubmitting}
                    className="w-full md:w-auto"
                  >
                    <Send className="w-4 h-4 mr-2" />
                    Send Message
                  </Button>
                </form>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Map Section */}
      <section className="py-16 bg-[var(--background-secondary)]">
        <div className="container">
          <div className="aspect-[21/9] rounded-2xl overflow-hidden bg-[var(--surface)] flex items-center justify-center">
            <div className="text-center">
              <MapPin className="w-12 h-12 mx-auto mb-4 text-[var(--foreground-muted)]" />
              <p className="text-[var(--foreground-muted)]">
                Interactive map would be displayed here
              </p>
            </div>
          </div>
        </div>
      </section>
    </div>
  );
}
