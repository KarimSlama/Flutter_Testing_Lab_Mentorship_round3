# Shopping Cart Architecture Diagram

## البنية الجديدة بعد التقسيم

```
┌─────────────────────────────────────────────────────────────┐
│                    ShoppingCart (Main Widget)               │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │  State Management & Coordination                        │ │
│  │  - CartManager instance                                 │ │
│  │  - Event handlers                                       │ │
│  └─────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
                                │
                                ▼
┌─────────────────────────────────────────────────────────────┐
│                    CartManager (Logic)                      │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │  Business Logic                                         │ │
│  │  - addItem()                                            │ │
│  │  - removeItem()                                         │ │
│  │  - updateQuantity()                                     │ │
│  │  - clearCart()                                          │ │
│  │  - Calculations (subtotal, discount, total)            │ │
│  └─────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
                                │
                                ▼
┌─────────────────────────────────────────────────────────────┐
│                    UI Components                            │
│                                                             │
│  ┌─────────────────┐  ┌─────────────────┐  ┌──────────────┐ │
│  │ AddItemButtons  │  │  CartSummary    │  │CartItemWidget│ │
│  │                 │  │                 │  │              │ │
│  │ - Add iPhone    │  │ - Total Items   │  │ - Item Info  │ │
│  │ - Add Galaxy    │  │ - Subtotal      │  │ - Quantity   │ │
│  │ - Add iPad      │  │ - Discount      │  │ - Controls   │ │
│  │ - Add iPhone    │  │ - Total Amount  │  │ - Delete     │ │
│  │   Again         │  │ - Clear Button  │  │              │ │
│  └─────────────────┘  └─────────────────┘  └──────────────┘ │
└─────────────────────────────────────────────────────────────┘
                                │
                                ▼
┌─────────────────────────────────────────────────────────────┐
│                    CartItem (Model)                         │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │  Data Model                                             │ │
│  │  - id, name, price                                      │ │
│  │  - quantity, discount                                   │ │
│  │  - Calculations (itemTotal, discountAmount)            │ │
│  └─────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

## تدفق البيانات

```
User Action → ShoppingCart → CartManager → State Update → UI Refresh
     │              │             │              │
     ▼              ▼             ▼              ▼
Button Click → Event Handler → Logic Update → Widget Rebuild
```

## فوائد التقسيم

### 1. فصل الاهتمامات (Separation of Concerns)

- **CartManager**: منطق العمل والحسابات
- **UI Components**: العرض والتفاعل
- **CartItem**: نموذج البيانات

### 2. سهولة الاختبار

- كل مكون يمكن اختباره بشكل منفصل
- اختبارات وحدة للـ CartManager
- اختبارات واجهة للمكونات

### 3. إعادة الاستخدام

- المكونات يمكن استخدامها في أماكن أخرى
- CartManager يمكن استخدامه في تطبيقات أخرى

### 4. الصيانة

- تعديل مكون واحد لا يؤثر على الآخرين
- أسهل في إضافة ميزات جديدة
- أسهل في إصلاح الأخطاء

## أمثلة على الاستخدام

### استخدام CartManager منفصل

```dart
final cartManager = CartManager();
cartManager.addItem('1', 'iPhone', 999.99, discount: 0.1);
print('Total: \$${cartManager.totalAmount}');
```

### استخدام المكونات منفصلة

```dart
CartSummary(
  totalItems: 5,
  subtotal: 100.0,
  totalDiscount: 10.0,
  totalAmount: 90.0,
  onClearCart: () => cartManager.clearCart(),
)
```

### استخدام الـ widget الرئيسي

```dart
ShoppingCart() // يستخدم كل المكونات تلقائياً
```
