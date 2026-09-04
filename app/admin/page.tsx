const cards = [
  ["الطلبات", "0", "إجمالي الطلبات"],
  ["المبيعات", "0 جنيه", "إجمالي المبيعات"],
  ["المنتجات", "0", "منتجات نشطة"],
  ["المخزون", "0", "تنبيهات المخزون"],
];

export default function AdminPage() {
  return (
    <main style={{padding:"36px 0"}}>
      <div className="container">
        <div style={{display:"flex",justifyContent:"space-between",alignItems:"center",marginBottom:28}}>
          <div><h1 style={{margin:"0 0 8px"}}>لوحة التحكم</h1><p style={{margin:0,color:"#777"}}>إدارة المتجر والمنتجات والطلبات.</p></div>
          <a className="btn" href="/">فتح المتجر</a>
        </div>
        <div className="grid" style={{marginBottom:30}}>
          {cards.map(([label,value,meta]) => <div className="card" key={label}><div className="cardBody"><div style={{color:"#777",fontSize:13}}>{label}</div><div style={{fontSize:30,fontWeight:800,marginTop:8}}>{value}</div><div style={{color:"#777",fontSize:13,marginTop:6}}>{meta}</div></div></div>)}
        </div>
        <div className="card"><div className="cardBody"><h2 style={{marginTop:0}}>الوحدات القادمة</h2><p style={{color:"#666",lineHeight:1.8}}>المنتجات، المقاسات والألوان، المخزون، الطلبات، العملاء، الكوبونات، الإعدادات، والصلاحيات ستصبح مربوطة بـSupabase في المرحلة التالية.</p></div></div>
      </div>
    </main>
  );
}
