import { Metadata } from "next";
import { siteConfig } from "@/config/navigation";

export const metadata: Metadata = {
  title: "Privacy Policy",
  description: "Privacy Policy for Poker Dream - How we collect, use, and protect your personal information.",
};

export default function PrivacyPage() {
  const lastUpdated = "January 1, 2025";

  return (
    <div className="pt-20">
      <section className="py-16 bg-[var(--background-secondary)]">
        <div className="container">
          <div className="max-w-3xl">
            <h1 className="text-4xl md:text-5xl font-bold mb-4">Privacy Policy</h1>
            <p className="text-[var(--foreground-secondary)]">
              Last updated: {lastUpdated}
            </p>
          </div>
        </div>
      </section>

      <section className="py-16">
        <div className="container">
          <div className="max-w-3xl mx-auto prose prose-invert">
            <div className="space-y-8">
              <div>
                <h2 className="text-2xl font-bold mb-4">1. Introduction</h2>
                <p className="text-[var(--foreground-secondary)]">
                  {siteConfig.name} (&quot;we,&quot; &quot;our,&quot; or &quot;us&quot;) is committed to protecting
                  your privacy. This Privacy Policy explains how we collect, use, disclose,
                  and safeguard your information when you visit our website, mobile application,
                  or participate in our tournaments.
                </p>
              </div>

              <div>
                <h2 className="text-2xl font-bold mb-4">2. Information We Collect</h2>
                <h3 className="text-lg font-semibold mb-2">Personal Information</h3>
                <p className="text-[var(--foreground-secondary)] mb-4">
                  We may collect personal information that you voluntarily provide when you:
                </p>
                <ul className="list-disc pl-6 text-[var(--foreground-secondary)] space-y-2">
                  <li>Register for tournaments</li>
                  <li>Create an account on our platform</li>
                  <li>Subscribe to our newsletter</li>
                  <li>Contact us for support</li>
                  <li>Apply for career opportunities</li>
                </ul>
                <p className="text-[var(--foreground-secondary)] mt-4">
                  This information may include your name, email address, phone number,
                  date of birth, nationality, and payment information.
                </p>

                <h3 className="text-lg font-semibold mb-2 mt-6">Automatically Collected Information</h3>
                <p className="text-[var(--foreground-secondary)]">
                  When you access our services, we may automatically collect certain information,
                  including your IP address, browser type, device information, and usage data
                  through cookies and similar technologies.
                </p>
              </div>

              <div>
                <h2 className="text-2xl font-bold mb-4">3. How We Use Your Information</h2>
                <p className="text-[var(--foreground-secondary)] mb-4">
                  We use the information we collect to:
                </p>
                <ul className="list-disc pl-6 text-[var(--foreground-secondary)] space-y-2">
                  <li>Process tournament registrations and payments</li>
                  <li>Communicate with you about tournaments and events</li>
                  <li>Send marketing communications (with your consent)</li>
                  <li>Improve our services and user experience</li>
                  <li>Comply with legal obligations</li>
                  <li>Prevent fraud and ensure security</li>
                </ul>
              </div>

              <div>
                <h2 className="text-2xl font-bold mb-4">4. Information Sharing</h2>
                <p className="text-[var(--foreground-secondary)] mb-4">
                  We may share your information with:
                </p>
                <ul className="list-disc pl-6 text-[var(--foreground-secondary)] space-y-2">
                  <li>Tournament partners and sponsors (limited to what&apos;s necessary)</li>
                  <li>Payment processors for transaction handling</li>
                  <li>Service providers who assist our operations</li>
                  <li>Legal authorities when required by law</li>
                </ul>
                <p className="text-[var(--foreground-secondary)] mt-4">
                  We do not sell your personal information to third parties.
                </p>
              </div>

              <div>
                <h2 className="text-2xl font-bold mb-4">5. Data Security</h2>
                <p className="text-[var(--foreground-secondary)]">
                  We implement appropriate technical and organizational measures to protect
                  your personal information against unauthorized access, alteration, disclosure,
                  or destruction. However, no method of transmission over the internet is
                  100% secure, and we cannot guarantee absolute security.
                </p>
              </div>

              <div>
                <h2 className="text-2xl font-bold mb-4">6. Your Rights</h2>
                <p className="text-[var(--foreground-secondary)] mb-4">
                  Depending on your location, you may have the right to:
                </p>
                <ul className="list-disc pl-6 text-[var(--foreground-secondary)] space-y-2">
                  <li>Access the personal information we hold about you</li>
                  <li>Request correction of inaccurate information</li>
                  <li>Request deletion of your personal information</li>
                  <li>Opt-out of marketing communications</li>
                  <li>Data portability</li>
                </ul>
              </div>

              <div>
                <h2 className="text-2xl font-bold mb-4">7. Cookies</h2>
                <p className="text-[var(--foreground-secondary)]">
                  We use cookies and similar tracking technologies to enhance your experience
                  on our website. You can control cookie preferences through your browser settings.
                  For more information, please see our Cookie Policy.
                </p>
              </div>

              <div>
                <h2 className="text-2xl font-bold mb-4">8. Children&apos;s Privacy</h2>
                <p className="text-[var(--foreground-secondary)]">
                  Our services are intended for individuals who are 21 years of age or older.
                  We do not knowingly collect personal information from children under 21.
                  If we become aware that we have collected information from a minor,
                  we will take steps to delete such information.
                </p>
              </div>

              <div>
                <h2 className="text-2xl font-bold mb-4">9. Changes to This Policy</h2>
                <p className="text-[var(--foreground-secondary)]">
                  We may update this Privacy Policy from time to time. We will notify you of
                  any changes by posting the new policy on this page and updating the
                  &quot;Last updated&quot; date.
                </p>
              </div>

              <div>
                <h2 className="text-2xl font-bold mb-4">10. Contact Us</h2>
                <p className="text-[var(--foreground-secondary)]">
                  If you have questions about this Privacy Policy or our privacy practices,
                  please contact us at:
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
