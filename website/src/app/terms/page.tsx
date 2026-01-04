import { Metadata } from "next";
import { siteConfig } from "@/config/navigation";

export const metadata: Metadata = {
  title: "Terms of Service",
  description: "Terms of Service for Poker Dream - Rules and conditions for using our services.",
};

export default function TermsPage() {
  const lastUpdated = "January 1, 2025";

  return (
    <div style={{ paddingTop: "80px" }}>
      <section className="py-16 bg-[var(--background-secondary)]">
        <div className="container">
          <div className="max-w-3xl">
            <h1 className="text-4xl md:text-5xl font-bold mb-4">Terms of Service</h1>
            <p className="text-[var(--foreground-secondary)]">
              Last updated: {lastUpdated}
            </p>
          </div>
        </div>
      </section>

      <section className="py-16">
        <div className="container">
          <div className="max-w-3xl mx-auto">
            <div className="space-y-8">
              <div>
                <h2 className="text-2xl font-bold mb-4">1. Acceptance of Terms</h2>
                <p className="text-[var(--foreground-secondary)]">
                  By accessing or using {siteConfig.name}&apos;s website, mobile application,
                  or participating in our tournaments, you agree to be bound by these Terms
                  of Service. If you do not agree to these terms, please do not use our services.
                </p>
              </div>

              <div>
                <h2 className="text-2xl font-bold mb-4">2. Eligibility</h2>
                <p className="text-[var(--foreground-secondary)] mb-4">
                  To use our services and participate in tournaments, you must:
                </p>
                <ul className="list-disc pl-6 text-[var(--foreground-secondary)] space-y-2">
                  <li>Be at least 21 years of age</li>
                  <li>Have the legal capacity to enter into a binding agreement</li>
                  <li>Not be prohibited from participating by any applicable laws</li>
                  <li>Provide accurate and complete registration information</li>
                </ul>
              </div>

              <div>
                <h2 className="text-2xl font-bold mb-4">3. Tournament Participation</h2>
                <h3 className="text-lg font-semibold mb-2">Registration</h3>
                <p className="text-[var(--foreground-secondary)] mb-4">
                  Tournament registration is subject to availability and our acceptance.
                  We reserve the right to refuse registration at our discretion.
                </p>

                <h3 className="text-lg font-semibold mb-2">Buy-ins and Fees</h3>
                <p className="text-[var(--foreground-secondary)] mb-4">
                  All tournament buy-ins and fees must be paid in full before participation.
                  Accepted payment methods will be specified during registration.
                </p>

                <h3 className="text-lg font-semibold mb-2">Tournament Rules</h3>
                <p className="text-[var(--foreground-secondary)]">
                  All participants must adhere to the Tournament Directors Association (TDA)
                  rules and any additional rules specified by {siteConfig.name}. Tournament
                  staff decisions are final.
                </p>
              </div>

              <div>
                <h2 className="text-2xl font-bold mb-4">4. Code of Conduct</h2>
                <p className="text-[var(--foreground-secondary)] mb-4">
                  Participants must conduct themselves professionally and respectfully.
                  The following behaviors are prohibited:
                </p>
                <ul className="list-disc pl-6 text-[var(--foreground-secondary)] space-y-2">
                  <li>Cheating, collusion, or chip dumping</li>
                  <li>Abusive or threatening behavior towards staff or players</li>
                  <li>Use of electronic devices at the table (unless authorized)</li>
                  <li>Disclosure of hand information during play</li>
                  <li>Any form of discrimination or harassment</li>
                </ul>
                <p className="text-[var(--foreground-secondary)] mt-4">
                  Violations may result in penalties, disqualification, or permanent bans.
                </p>
              </div>

              <div>
                <h2 className="text-2xl font-bold mb-4">5. Refunds and Cancellations</h2>
                <p className="text-[var(--foreground-secondary)] mb-4">
                  Refund policies vary by tournament. Generally:
                </p>
                <ul className="list-disc pl-6 text-[var(--foreground-secondary)] space-y-2">
                  <li>Full refunds available up to 48 hours before tournament start</li>
                  <li>50% refund available 24-48 hours before tournament start</li>
                  <li>No refunds within 24 hours of tournament start</li>
                  <li>No refunds after cards are in the air</li>
                </ul>
                <p className="text-[var(--foreground-secondary)] mt-4">
                  Specific refund terms will be stated at registration.
                </p>
              </div>

              <div>
                <h2 className="text-2xl font-bold mb-4">6. Prize Distribution</h2>
                <p className="text-[var(--foreground-secondary)]">
                  Prizes will be distributed according to the published payout structure.
                  Winners must provide valid identification and complete any required
                  tax documentation. We reserve the right to withhold prizes pending
                  verification of eligibility and compliance with these terms.
                </p>
              </div>

              <div>
                <h2 className="text-2xl font-bold mb-4">7. Intellectual Property</h2>
                <p className="text-[var(--foreground-secondary)]">
                  All content on our website and applications, including logos, text,
                  images, and software, is the property of {siteConfig.name} or its
                  licensors. You may not use, reproduce, or distribute our intellectual
                  property without written permission.
                </p>
              </div>

              <div>
                <h2 className="text-2xl font-bold mb-4">8. Media Rights</h2>
                <p className="text-[var(--foreground-secondary)]">
                  By participating in our tournaments, you grant {siteConfig.name} the
                  right to use your name, likeness, and image in promotional materials,
                  broadcasts, and other media without additional compensation.
                </p>
              </div>

              <div>
                <h2 className="text-2xl font-bold mb-4">9. Limitation of Liability</h2>
                <p className="text-[var(--foreground-secondary)]">
                  To the maximum extent permitted by law, {siteConfig.name} shall not be
                  liable for any indirect, incidental, special, or consequential damages
                  arising from your use of our services or participation in tournaments.
                  Our total liability shall not exceed the amount you paid for the
                  specific service giving rise to the claim.
                </p>
              </div>

              <div>
                <h2 className="text-2xl font-bold mb-4">10. Disclaimer</h2>
                <p className="text-[var(--foreground-secondary)]">
                  Our services are provided &quot;as is&quot; without warranties of any kind.
                  We do not guarantee uninterrupted or error-free operation of our
                  website or applications. Poker involves risk, and past performance
                  does not guarantee future results.
                </p>
              </div>

              <div>
                <h2 className="text-2xl font-bold mb-4">11. Responsible Gaming</h2>
                <p className="text-[var(--foreground-secondary)]">
                  We promote responsible gaming. If you believe you have a gambling problem,
                  please seek help from professional resources. We reserve the right to
                  exclude individuals who show signs of problem gambling.
                </p>
              </div>

              <div>
                <h2 className="text-2xl font-bold mb-4">12. Governing Law</h2>
                <p className="text-[var(--foreground-secondary)]">
                  These Terms of Service shall be governed by and construed in accordance
                  with the laws of Malaysia. Any disputes shall be resolved in the courts
                  of Malaysia.
                </p>
              </div>

              <div>
                <h2 className="text-2xl font-bold mb-4">13. Changes to Terms</h2>
                <p className="text-[var(--foreground-secondary)]">
                  We may update these terms at any time. Continued use of our services
                  after changes constitutes acceptance of the new terms.
                </p>
              </div>

              <div>
                <h2 className="text-2xl font-bold mb-4">14. Contact Information</h2>
                <p className="text-[var(--foreground-secondary)]">
                  For questions about these Terms of Service, please contact us:
                </p>
                <div className="mt-4 p-4 bg-[var(--surface)] rounded-lg">
                  <p className="text-[var(--foreground-secondary)]">
                    <strong>Email:</strong> {siteConfig.email}
                    <br />
                    <strong>Phone:</strong> {siteConfig.phone}
                    <br />
                    <strong>Address:</strong> {siteConfig.address.line1}, {siteConfig.address.city}, {siteConfig.address.country}
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
    </div>
  );
}
