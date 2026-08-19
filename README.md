# Chaitanya_sql
# SQL Practicals

MySQL database practicals covering schema design, constraints, relationships, and CRUD operations.

## Contents

| # | Database | Description |
|---|----------|-------------|
| 1 | `ecommerce_db` | E-commerce platform schema — customers, products, orders, payments, reviews, and cart |
| 2 | `college_demo` | College management schema — departments, students, courses, faculty, and enrollments |

---

## 1. `ecommerce_db`

An e-commerce database modeling a typical online store.

**Tables:** `Categories`, `Customers`, `Addresses`, `Suppliers`, `Products`, `Orders`, `Order_Items`, `Payments`, `Reviews`, `Cart`

**Highlights:**
- `ENUM` types for status fields (order status, payment method/status, gender)
- `CHECK` constraints for data validation (price, discount %, stock, rating)
- Generated column: `Order_Items.subtotal` computed as `quantity * unit_price`
- Foreign keys with mixed `ON DELETE` behavior (`CASCADE`, `RESTRICT`, `SET NULL`)
- Sample data pre-loaded for all tables

**Setup:**
```bash
mysql -u root -p < ecommerce_db.sql
```

---

## 2. `college_demo`

A college management database modeling departments, students, courses, and enrollments.

**Tables:** `department`, `student`, `course`, `enrollment`, `faculty`, `employee`

**Highlights:**
- Composite primary key on `enrollment` (`roll_no`, `course_id`, `semester`)
- `CHECK` constraint restricting `semester` to 1–8
- Foreign keys linking students, courses, and faculty back to `department`
- Unique constraints on `email`, `aadhar_no`, and `phone_no`

**Setup:**
```bash
mysql -u root -p < college_demo.sql
```

---

## Requirements

- MySQL 8.0+ (for generated columns and `CHECK` constraint support)

## Usage

```bash
mysql -u root -p
SOURCE path/to/script.sql;
```

## Author

Chaitanya
