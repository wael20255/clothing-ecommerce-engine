const demoProducts = [
  { name: "تيشيرت أوفر سايز", price: "599 جنيه", meta: "أسود · أبيض · 4 مقاسات" },
  { name: "هودي أساسي", price: "899 جنيه", meta: "5 ألوان · 5 مقاسات" },
  { name: "بنطلون كارغو", price: "749 جنيه", meta: "3 ألوان · 6 مقاسات" },
  { name: "جاكيت يومي", price: "1,199 جنيه", meta: "2 لون · 5 مقاسات" },
];

export default function Home() {
  return (
    <>
      <header className="header">
        <div className="container headerInner">
          <a className="logo" href="#">CLOTHING</a>
          <nav className="nav">
            <a href="#">الرئيسية</a>
            <a href="#products">المنتجات</a>
            <a href="#categories">الأقسام</a>
            <a href="#offers">العروض</a>
          </nav>
          <a className="cart" href="#cart">السلة (0)</a>
        </div>
      </header>

      <main>
        <section className="hero">
          <div className="container heroBox">
            <div>
              <div style={{fontSize:14,fontWeight:700,marginBottom:10}}>NEW COLLECTION</div>
              <h1>ستايلك يبدأ من هنا.</h1>
              <p>متجر ملابس حديث قابل للتخصيص، مصمم ليكبر مع البراند والمنتجات والطلبات.</p>
              <a className="btn" href="#products">تسوق الآن</a>
            </div>
            <div style={{fontSize:70,opacity:.18,fontWeight:900}}>01</div>
          </div>
        </section>

        <section className="section" id="categories">
          <div className="container">
            <div className="sectionTitle"><div><h2>الأقسام</h2><p>كل ما تحتاجه في مكان واحد</p></div></div>
            <div className="grid">
              {['تيشيرتات','هوديز','بنطلونات','جاكيتات'].map((item) => (
                <a className="card" href="#products" key={item}><div className="thumb">{item}</div><div className="cardBody"><strong>{item}</strong></div></a>
              ))}
            </div>
          </div>
        </section>

        <section className="section" id="products">
          <div className="container">
            <div className="sectionTitle"><div><h2>منتجات مميزة</h2><p>البيانات الحالية تجريبية حتى ربط Supabase</p></div><a href="#" style={{fontSize:14}}>عرض الكل ←</a></div>
            <div className="grid">
              {demoProducts.map((product) => (
                <article className="card" key={product.name}>
                  <div className="thumb">صورة المنتج</div>
                  <div className="cardBody">
                    <strong>{product.name}</strong>
                    <div style={{fontSize:13,color:'#777',marginTop:6}}>{product.meta}</div>
                    <div className="price">{product.price}</div>
                  </div>
                </article>
              ))}
            </div>
          </div>
        </section>

        <section className="section" id="offers">
          <div className="container">
            <div className="heroBox" style={{padding:30}}>
              <div><h2 style={{margin:'0 0 8px'}}>محرك متجر قابل لإعادة الاستخدام</h2><p style={{margin:0}}>المنتجات والمخزون والطلبات والإعدادات ستصبح ديناميكية بالكامل بعد ربط Supabase.</p></div>
              <span className="btn">جاهز للتطوير</span>
            </div>
          </div>
        </section>
      </main>

      <footer className="footer"><div className="container">Clothing Ecommerce Engine · مستقل عن Botera</div></footer>
    </>
  );
}
