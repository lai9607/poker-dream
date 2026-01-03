import {
  HeroSection,
  FeaturedTournaments,
  WinnersCarousel,
  NewsHighlights,
  SponsorsSection,
  CTASection,
} from "@/components/sections";

export default function HomePage() {
  return (
    <>
      <HeroSection />
      <FeaturedTournaments />
      <WinnersCarousel />
      <NewsHighlights />
      <CTASection />
      <SponsorsSection />
    </>
  );
}
