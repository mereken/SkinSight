////package com.skinsight.product.repository;
////
////import com.skinsight.product.entity.Product;
////import org.springframework.data.domain.Page;
////import org.springframework.data.domain.Pageable;
////import org.springframework.data.jpa.repository.JpaRepository;
////import org.springframework.data.jpa.repository.Query;
////import org.springframework.data.repository.query.Param;
////
////public interface ProductRepository extends JpaRepository<Product, Long> {
////
////    @Query("""
////        SELECT DISTINCT p FROM Product p
////        WHERE (:search IS NULL OR LOWER(p.name) LIKE LOWER(CONCAT('%', :search, '%'))
////                               OR LOWER(p.brand) LIKE LOWER(CONCAT('%', :search, '%')))
////        AND   (:category IS NULL OR LOWER(p.category) = LOWER(:category))
////    """)
////    Page<Product> searchProducts(
////            @Param("search") String search,
////            @Param("category") String category,
////            Pageable pageable
////    );
////}
////
////
//
//
//
//package com.skinsight.product.repository;
//
//import com.skinsight.product.entity.Product;
//import org.springframework.data.domain.Page;
//import org.springframework.data.domain.Pageable;
//import org.springframework.data.jpa.repository.JpaRepository;
//import org.springframework.data.jpa.repository.Query;
//import org.springframework.data.repository.query.Param;
//
//public interface ProductRepository extends JpaRepository<Product, Long> {
//
//    @Query("""
//        SELECT DISTINCT p FROM Product p
//        WHERE (:search IS NULL OR LOWER(p.name) LIKE :search OR LOWER(p.brand) LIKE :search)
//        AND   (:category IS NULL OR LOWER(p.category) = :category)
//    """)
//    Page<Product> searchProducts(
//            @Param("search") String search,
//            @Param("category") String category,
//            Pageable pageable
//    );
//}


package com.skinsight.product.repository;

import com.skinsight.product.entity.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface ProductRepository extends JpaRepository<Product, Long> {

    @Query("""
        SELECT DISTINCT p FROM Product p
        WHERE (:search = '' OR LOWER(p.name) LIKE :search OR LOWER(p.brand) LIKE :search)
        AND   (:category = '' OR LOWER(p.category) = :category)
    """)
    Page<Product> searchProducts(
            @Param("search") String search,
            @Param("category") String category,
            Pageable pageable
    );
}