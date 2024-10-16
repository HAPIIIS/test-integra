    erDiagram
        SUPPLIER ||--o{ PURCHASE_ORDER : "membuat"
        PURCHASE_ORDER ||--o{ PO_DETAIL : "memiliki"
        PRODUCT ||--o{ PO_DETAIL : "termasuk"
        SUPPLIER ||--o{ SURAT_JALAN : "mengirim"
        SURAT_JALAN ||--o{ SJ_DETAIL : "memiliki"
        PRODUCT ||--o{ SJ_DETAIL : "termasuk"
        PO_DETAIL ||--o{ SJ_DETAIL : "terkait"

    SUPPLIER {
        int supplier_id PK
        string nama
        string alamat
        string telepon
        string email
        datetime created_at
        datetime updated_at
    }

    PURCHASE_ORDER {
        int po_id PK
        int supplier_id FK
        string nomor_po
        date tanggal_po
        decimal total_amount
        enum status
        string catatan
        datetime created_at
        datetime updated_at
    }

    PO_DETAIL {
        int po_detail_id PK
        int po_id FK
        int product_id FK
        int quantity
        decimal harga
        decimal subtotal
        datetime created_at
        datetime updated_at
    }

    PRODUCT {
        int product_id PK
        string kode
        string nama
        string deskripsi
        string satuan
        decimal harga
        int stok
        datetime created_at  
        datetime updated_at
    }

    SURAT_JALAN {
        int sj_id PK
        int supplier_id FK
        string nomor_sj
        date tanggal_sj
        enum status
        string catatan
        datetime created_at
        datetime updated_at
    }

    SJ_DETAIL {
        int sj_detail_id PK
        int sj_id FK
        int product_id FK
        int po_detail_id FK
        int quantity
        datetime created_at
        datetime updated_at
    }


Mockup : <a href="https://www.figma.com/proto/tSCrsGzJhc0mAOwKNSkjee/Mockup-Integra?node-id=0-1&t=53DhuI23XaXQMJOs-1">Mockup</a> 
