package com.skinsight.product.service;

import com.skinsight.common.exception.AppException;
import com.skinsight.ingredient.entity.Ingredient;
import com.skinsight.ingredient.repository.IngredientRepository;
import com.skinsight.product.dto.ProductDto.*;
import com.skinsight.product.entity.*;
import com.skinsight.product.repository.ProductRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.*;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ProductService {

    private final ProductRepository productRepository;
    private final IngredientRepository ingredientRepository;

//    public Page<ProductSummary> search(String query, String category, int page, int size) {
//        Pageable pageable = PageRequest.of(page, size, Sort.by("name"));
//
//
//        return productRepository.searchProducts(query, category, pageable).map(this::toSummary);
//    }

    public Page<ProductSummary> search(String query, String category, int page, int size) {
        Pageable pageable = PageRequest.of(page, size, Sort.by("name"));

        // Передаем "", если запрос пустой (никаких null!)
        String searchParam = (query != null && !query.isBlank())
                ? "%" + query.toLowerCase() + "%"
                : "";

        // Передаем "", если категория пустая (никаких null!)
        String categoryParam = (category != null && !category.isBlank())
                ? category.toLowerCase()
                : "";

        return productRepository.searchProducts(searchParam, categoryParam, pageable)
                .map(this::toSummary);
    }


    public ProductDetail getById(Long id) {
        Product product = productRepository.findById(id)
                .orElseThrow(() -> new AppException("Product not found", HttpStatus.NOT_FOUND));
        return toDetail(product);
    }

    @Transactional
    public ProductDetail create(CreateRequest request) {
        Product product = Product.builder()
                .name(request.getName())
                .brand(request.getBrand())
                .category(request.getCategory())
                .description(request.getDescription())
                .imageUrl(request.getImageUrl())
                .productIngredients(new ArrayList<>())
                .build();
        product = productRepository.save(product);
        if (request.getIngredientIds() != null) {
            for (int i = 0; i < request.getIngredientIds().size(); i++) {
                Ingredient ingredient = ingredientRepository.findById(request.getIngredientIds().get(i))
                        .orElseThrow(() -> new AppException("Ingredient not found", HttpStatus.NOT_FOUND));
                product.getProductIngredients().add(ProductIngredient.builder()
                        .product(product).ingredient(ingredient).position(i + 1).build());
            }
            productRepository.save(product);
        }
        return toDetail(product);
    }

    @Transactional
    public ProductDetail update(Long id, CreateRequest request) {
        Product product = productRepository.findById(id)
                .orElseThrow(() -> new AppException("Product not found", HttpStatus.NOT_FOUND));
        if (request.getName() != null)        product.setName(request.getName());
        if (request.getBrand() != null)       product.setBrand(request.getBrand());
        if (request.getCategory() != null)    product.setCategory(request.getCategory());
        if (request.getDescription() != null) product.setDescription(request.getDescription());
        if (request.getImageUrl() != null)    product.setImageUrl(request.getImageUrl());
        return toDetail(productRepository.save(product));
    }

    @Transactional
    public void delete(Long id) {
        if (!productRepository.existsById(id))
            throw new AppException("Product not found", HttpStatus.NOT_FOUND);
        productRepository.deleteById(id);
    }

    public ProductSummary toSummary(Product p) {
        ProductSummary s = new ProductSummary();
        s.setId(p.getId());
        s.setName(p.getName());
        s.setBrand(p.getBrand());
        s.setCategory(p.getCategory());
        s.setImageUrl(p.getImageUrl());
        return s;
    }

    public ProductDetail toDetail(Product p) {
        ProductDetail d = new ProductDetail();
        d.setId(p.getId());
        d.setName(p.getName());
        d.setBrand(p.getBrand());
        d.setCategory(p.getCategory());
        d.setDescription(p.getDescription());
        d.setImageUrl(p.getImageUrl());
        d.setIngredients(p.getProductIngredients().stream().map(pi -> {
            ProductDetail.IngredientItem item = new ProductDetail.IngredientItem();
            item.setId(pi.getIngredient().getId());
            item.setInciName(pi.getIngredient().getInciName());
            item.setCommonName(pi.getIngredient().getCommonName());
            item.setFunctions(pi.getIngredient().getFunctions());
            item.setPosition(pi.getPosition());
            return item;
        }).toList());
        return d;
    }
}
