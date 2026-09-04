import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "Clothing Store",
  description: "Reusable clothing ecommerce engine",
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="ar" dir="rtl">
      <body>{children}</body>
    </html>
  );
}
