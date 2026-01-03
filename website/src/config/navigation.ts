import { NavItem } from "@/types";

export const mainNavigation: NavItem[] = [
  {
    label: "Home",
    href: "/",
  },
  {
    label: "Tournaments",
    href: "/tournaments",
  },
  {
    label: "DPOY",
    href: "/dpoy",
  },
  {
    label: "Live Reports",
    href: "/live-reports",
  },
  {
    label: "Gallery",
    href: "/gallery",
    children: [
      { label: "Tournament Photos", href: "/gallery/tournaments" },
      { label: "Champions", href: "/gallery/champions" },
    ],
  },
  {
    label: "News",
    href: "/news",
  },
];

export const footerNavigation = {
  company: [
    { label: "About Us", href: "/about" },
    { label: "Contact", href: "/contact" },
    { label: "Careers", href: "/careers" },
  ],
  legal: [
    { label: "Privacy Policy", href: "/privacy" },
    { label: "Terms of Service", href: "/terms" },
  ],
  social: [
    { label: "Facebook", href: "https://facebook.com/pokerdream", icon: "facebook" },
    { label: "Instagram", href: "https://instagram.com/pokerdream", icon: "instagram" },
    { label: "Twitter", href: "https://twitter.com/pokerdream", icon: "twitter" },
    { label: "YouTube", href: "https://youtube.com/pokerdream", icon: "youtube" },
    { label: "WhatsApp", href: "https://wa.me/pokerdream", icon: "whatsapp" },
  ],
};

export const siteConfig = {
  name: "Poker Dream",
  description: "Asia's Premier Poker Tournament Series",
  tagline: "Where Champions Are Made",
  url: "https://pokerdream.com",
  email: "info@pokerdream.com",
  phone: "+60 12-345-6789",
  address: {
    line1: "Resorts World Genting",
    line2: "Genting Highlands",
    city: "Pahang",
    country: "Malaysia",
    postalCode: "69000",
  },
};
