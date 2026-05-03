package com.skinsight.product.entity;

import java.io.Serializable;
import lombok.*;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @EqualsAndHashCode
public class ProductIngredientId implements Serializable {
    private Long product;
    private Long ingredient;
}
