import type { Metadata } from 'next'; import './globals.css';
export const metadata: Metadata={title:'Pemuda Karang Baru',description:'Website resmi Pemuda Karang Baru'};
export default function RootLayout({children}:{children:React.ReactNode}){return <html lang="id"><body>{children}</body></html>}
