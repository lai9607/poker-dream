# Poker Dream Website Development Proposal

## Executive Summary

This proposal outlines the development of a responsive website for Poker Dream, modeled after pokerdream-live.com, integrated with your existing backend infrastructure. The website will serve as the public-facing platform for tournament information, player rankings, news, and brand presence.

---

## Website Analysis: pokerdream-live.com

### Total Pages Identified: **14-16 Main Pages**

| # | Page | Description | Complexity |
|---|------|-------------|------------|
| 1 | Home | Landing page with hero section, featured tournaments, winners gallery carousel, Instagram feed, newsletter signup | High |
| 2 | Tournament (List) | Searchable/filterable tournament listing with pagination, status indicators | High |
| 3 | Tournament (Detail) | Individual tournament pages with live timer, blind levels, chip counts, payout structures, player standings | Very High |
| 4 | DPOY (Leaderboard) | Player of the Year rankings with 50+ entries per page, points system, pagination | Medium |
| 5 | Live Reports | Tournament updates hub with event cards | Medium |
| 6 | Live Report (Detail) | Individual tournament live report pages | Medium |
| 7 | Gallery - Tournament | Photo gallery organized by tournament series (PD10-PD18+) | Medium |
| 8 | Gallery - Champion | Winner photos grid with 200+ images | Medium |
| 9 | News/Events | Promotions and announcements grid with article cards | Medium |
| 10 | News Article (Detail) | Individual news/promotion detail pages | Low |
| 11 | About Us | Company information, mission, team credentials | Low |
| 12 | Contact Us | Partnership inquiry form, social links | Low |
| 13 | Career | Job listings (7 positions) with detailed descriptions | Low |
| 14 | Privacy Policy | Legal documentation | Low |
| 15 | Terms of Service | Legal documentation | Low |

### Key Features Identified

1. **Real-time Tournament Tracking**
   - Live blind level timer with countdown
   - Current average chip count
   - Prize pool calculations
   - Payout structure display

2. **Player Ranking System (DPOY)**
   - Points-based leaderboard
   - Multi-page pagination
   - Country flags and player profiles

3. **Content Management**
   - News/Events publishing
   - Tournament schedules
   - Photo galleries (Tournament & Champions)

4. **User Engagement**
   - Newsletter subscription
   - Social media integration (FB, IG, Twitter, WhatsApp, YouTube)
   - Partnership inquiry forms

5. **Multi-language Support**
   - Player guides in English and Chinese

---

## Technical Approach

### Option A: Full Custom Development (Recommended)
Build a custom React/Next.js website integrated directly with your existing backend APIs.

**Pros:**
- Full control over design and functionality
- Direct API integration with your existing backend
- Shared data models between Flutter app and website
- Better performance and SEO with Next.js
- Scalable and maintainable

**Cons:**
- Higher initial development cost
- Longer development timeline

### Option B: WordPress + Custom API Integration
Use WordPress with Elementor (like pokerdream-live.com) with custom plugins for API integration.

**Pros:**
- Faster content management setup
- Non-technical staff can update content
- Lower initial cost

**Cons:**
- Limited customization for real-time features
- Additional complexity for API integration
- WordPress security maintenance required
- Potential performance issues with custom plugins

### Recommendation: **Option A (Next.js)**
Given you already have a Flutter app with structured data models and will need real-time tournament features, a custom Next.js build will provide better integration, performance, and long-term maintainability.

---

## Development Scope & Timeline

### Phase 1: Foundation & Core Pages
**Duration: 3-4 weeks**

| Task | Est. Hours |
|------|------------|
| Project setup (Next.js, TypeScript, Tailwind CSS) | 8 |
| Design system & component library | 24 |
| Responsive layout framework | 16 |
| Home page with all sections | 32 |
| About Us page | 8 |
| Contact Us page with form | 12 |
| Career page with job listings | 12 |
| Privacy Policy & Terms pages | 4 |
| **Phase 1 Total** | **116 hours** |

### Phase 2: Tournament System
**Duration: 4-5 weeks**

| Task | Est. Hours |
|------|------------|
| Tournament list page with filters/search | 24 |
| Tournament detail page | 32 |
| Real-time blind level timer | 16 |
| Payout structure display | 12 |
| Player standings integration | 16 |
| Backend API integration | 24 |
| **Phase 2 Total** | **124 hours** |

### Phase 3: Player & Rankings
**Duration: 2-3 weeks**

| Task | Est. Hours |
|------|------------|
| DPOY leaderboard page | 20 |
| Player profile pages | 24 |
| Pagination & infinite scroll | 8 |
| Backend API integration | 16 |
| **Phase 3 Total** | **68 hours** |

### Phase 4: Content & Media
**Duration: 2-3 weeks**

| Task | Est. Hours |
|------|------------|
| News/Events listing page | 16 |
| News article detail page | 12 |
| Live Reports section | 16 |
| Tournament gallery | 20 |
| Champion gallery | 16 |
| Image optimization & CDN setup | 8 |
| **Phase 4 Total** | **88 hours** |

### Phase 5: Integration & Launch
**Duration: 2 weeks**

| Task | Est. Hours |
|------|------------|
| Newsletter integration | 8 |
| Social media feeds (Instagram) | 12 |
| Analytics setup (Google Analytics) | 4 |
| SEO optimization | 12 |
| Multi-language support (EN/CN) | 24 |
| Testing & QA | 24 |
| Deployment & DevOps | 16 |
| **Phase 5 Total** | **100 hours** |

---

## Cost Estimate

### Development Hours Summary

| Phase | Hours | Description |
|-------|-------|-------------|
| Phase 1 | 116 | Foundation & Core Pages |
| Phase 2 | 124 | Tournament System |
| Phase 3 | 68 | Player & Rankings |
| Phase 4 | 88 | Content & Media |
| Phase 5 | 100 | Integration & Launch |
| **Total** | **496 hours** |

### Pricing Options

#### Option 1: Fixed Price Project
| Item | Cost (RM) |
|------|-----------|
| Development (496 hrs @ RM 340/hr) | RM 168,640 |
| UI/UX Design | RM 22,000 - RM 35,000 |
| Project Management (10%) | RM 16,864 |
| **Total Estimate** | **RM 207,500 - RM 220,500** |

#### Option 2: Phased Delivery (Pay Per Phase)
| Phase | Hours | Cost (RM) |
|-------|-------|-----------|
| Phase 1: Foundation | 116 | RM 39,440 |
| Phase 2: Tournaments | 124 | RM 42,160 |
| Phase 3: Players | 68 | RM 23,120 |
| Phase 4: Content | 88 | RM 29,920 |
| Phase 5: Launch | 100 | RM 34,000 |
| Design (upfront) | - | RM 22,000 |
| **Total** | **496** | **RM 190,640** |

#### Option 3: MVP First (Minimum Viable Product) - RECOMMENDED
Launch with essential features first, expand later:

**MVP Scope (8-10 weeks):**
- Home page
- Tournament list & detail
- About/Contact/Career pages
- Basic gallery
- News section

| Item | Cost (RM) |
|------|-----------|
| MVP Development (~300 hrs) | RM 102,000 |
| Design | RM 18,000 |
| **MVP Total** | **RM 120,000** |

**Post-MVP Additions:**
- DPOY System: RM 23,000
- Real-time features: RM 27,000
- Multi-language: RM 13,500
- Advanced galleries: RM 18,000

---

## Monthly Recurring Costs

| Service | Est. Monthly Cost |
|---------|------------------|
| Hosting (Vercel/AWS) | RM 225 - RM 900 |
| CDN (Cloudflare) | RM 0 - RM 225 |
| Email service (newsletter) | RM 90 - RM 225 |
| Domain renewal (annual) | ~RM 70/year |
| SSL Certificate | Free (Let's Encrypt) |
| **Estimated Monthly** | **RM 315 - RM 1,350** |

---

## Timeline Overview

```
Week 1-4:   Phase 1 - Foundation & Core Pages
Week 5-9:   Phase 2 - Tournament System
Week 10-12: Phase 3 - Player & Rankings
Week 13-15: Phase 4 - Content & Media
Week 16-17: Phase 5 - Integration & Launch

Total: 13-17 weeks (3-4 months)
```

---

## Backend Integration Points

Based on your existing Flutter app structure, the following data will be shared:

| Feature | Flutter Feature | Website Equivalent |
|---------|-----------------|-------------------|
| Tournaments | `features/tournaments/` | Tournament pages |
| Events | `features/events/` | Events listing |
| Players | `features/players/` | DPOY & profiles |
| News | `features/news/` | News/Events section |
| Live | `features/live/` | Live Reports |

### Required API Endpoints

1. `GET /api/tournaments` - List tournaments
2. `GET /api/tournaments/:id` - Tournament details
3. `GET /api/tournaments/:id/standings` - Player standings
4. `GET /api/players/leaderboard` - DPOY rankings
5. `GET /api/players/:id` - Player profile
6. `GET /api/news` - News articles
7. `GET /api/galleries/:type` - Photo galleries
8. `POST /api/newsletter/subscribe` - Newsletter signup
9. `POST /api/contact` - Contact form submission

---

## Deliverables

1. **Source Code** - Full Next.js codebase with documentation
2. **Design Files** - Figma/Sketch files for all pages
3. **API Documentation** - Integration specs for backend team
4. **Deployment Guide** - Step-by-step deployment instructions
5. **Admin Guide** - Content management documentation
6. **Training Session** - 2-hour walkthrough for your team

---

## Next Steps

1. **Confirm scope** - Review and finalize page requirements
2. **Design phase** - Create mockups for approval
3. **API planning** - Finalize backend endpoints needed
4. **Development kickoff** - Begin Phase 1 development
5. **Weekly reviews** - Progress demos and feedback

---

## Contact

For questions or to proceed with this proposal, please reach out.

---

*Proposal Date: December 12, 2025*
*Valid for: 30 days*
