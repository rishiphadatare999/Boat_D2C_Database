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
<img width="1224" height="634" alt="image" src="https://github.com/DilipBaduwal/Udaan_B2B_Group9_Sec_C/blob/main/image.png?raw=true" />


## Project Overview

This system ensures seamless coordination between:
- **Customer**
- **Supplier**
- **Warehouse**
- **Driver**
- **SKU**
- **Product**
- **Orders**
- **Logistics**


It provides accurate tracking of supplier listings, product assortments, shipments, pricing, and retailer order fulfillment across the Udaan network.

---

## Relationships References 

| Module | Dependencies | Insert after |
|--------|--------------|--------------|
| customer_data | `None`| `First` |
| product | `None`| `After customer_data` |
| sku | `product(product_id)`| `After sku` |
| warehouse | `sku(sku_id)`|`After sku` |
| driver_detail | `warehouse(warehouse_id)`|`After warehouse` |
| placed_orders | `customer_data(customer_id)`, ` sku(sku_id)`| `After customer_data`, `sku` |
| supplier | `sku(product_id)`, `warehouse(warehouse_id)` , `sku(sku_id)` | `After sku`,`warehouse`|
| logistic | `placed_orders(order_id)`, `warehouse` , `driver_detail`  | `After placed_orders`,`warehouse`,`driver_detail`|

---
