# ETB
<div style="text-align: center;"> <h3></h3> <p><strong>Database Management Project</strong></p>
<p><strong>Group: 19</strong></p>


<p text-align: center><strong>Submitted to: Prof. Ashok Harnal</strong></p>


<p text-align: center><strong>Submitted By:</strong></p>

<ul>
    <li>Rajat Joshi - 341125</li>
    <li>Souravh Ghosh - 341175</li>
    <li>Rushi Phadatare - 341180</li>
</ul>
</div>

# End‑to‑End D2C E‑Commerce of Boat Marketplace

This project designs a relational database for boAt’s Direct-to-Consumer (D2C) e-commerce ecosystem, enabling the brand to sell audio and lifestyle products directly to end customers through its owned digital channels. The system connects Customers, Products, SKUs, Warehouses, Inventory, Delivery Partners, and Orders, capturing the complete order lifecycle from customer purchase to last-mile delivery. 

The entities and their relationships are structured to support core D2C operations such as product catalog and SKU management, real-time inventory visibility across fulfillment centers, order orchestration, shipment routing to delivery partners, and end-to-end order tracking. The design also enables returns and replacements handling, customer-level analytics, and performance measurement across fulfillment, delivery timelines, and service quality, supporting data-driven optimization of boAt’s D2C supply chain and customer experience.

---

<img width="1224" height="750" alt="image" src="https://github.com/Rajat92358/flipkart-database-project/blob/main/Screenshot%202025-12-16%20190428.png" />


## Project Overview

This system ensures seamless coordination between:
- **Customer**
- **Product**
- **Product Variant**
- **Category**
- **Cart**
- **Cart Item**
- **Wishlist**
- **Order**
- **Order Item**
- **Payment**
- **Coupon**
- **Shipping**
- **Review**


It provides accurate tracking of boAt’s product catalog, SKU-level assortments, inventory movements, order shipments, pricing, and end-customer order fulfillment across boAt’s direct-to-consumer ecosystem.

---

## Relationships References 

| Module           | Dependencies                                             | Insert after                          |
| ---------------- | -------------------------------------------------------- | ------------------------------------- |
| category         | `None`                                                   | `First`                               |
| product          | `category(category_id)`                                  | `After category`                      |
| product_variants | `product(product_id)`                                    | `After product`                       |
| customers        | `None`                                                   | `After category`                      |
| carts            | `customers(customer_id)`                                 | `After customers`                     |
| cart_items       | `carts(cart_id)`, `product_variants(variant_id)`         | `After carts`, `product_variants`     |
| wishlist         | `customers(customer_id)`, `product_variants(variant_id)` | `After customers`, `product_variants` |
| orders           | `customers(customer_id)`, `coupons(coupon_id)`           | `After customers`, `coupons`          |
| order_items      | `orders(order_id)`, `product_variants(variant_id)`       | `After orders`, `product_variants`    |
| payments         | `orders(order_id)`                                       | `After orders`                        |
| shipping         | `orders(order_id)`                                       | `After orders`                        |
| coupons          | `None`                                                   | `After customers`                     |
| reviews          | `customers(customer_id)`, `orders(order_id)`             | `After customers`, `orders`           |

---
