package com.skinsight.ingredient.service;

import com.skinsight.common.exception.AppException;
import com.skinsight.ingredient.dto.IngredientDto.*;
import com.skinsight.ingredient.entity.*;
import com.skinsight.ingredient.repository.IngredientRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.*;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class IngredientService {

    private final IngredientRepository ingredientRepository;

    public Page<IngredientDetail> search(String query, int page, int size) {
        Pageable pageable = PageRequest.of(page, size, Sort.by("inciName"));
        if (query != null && !query.isBlank()) {
            return ingredientRepository.findAll(pageable).map(this::toDetail);
        }
        return ingredientRepository.findAll(pageable).map(this::toDetail);
    }

    public IngredientDetail getById(Long id) {
        return toDetail(ingredientRepository.findById(id)
                .orElseThrow(() -> new AppException("Ingredient not found", HttpStatus.NOT_FOUND)));
    }

    @Transactional
    public IngredientDetail create(IngredientCreateRequest request) {
        Ingredient ingredient = Ingredient.builder()
                .inciName(request.getInciName().toUpperCase())
                .commonName(request.getCommonName())
                .description(request.getDescription())
                .functions(request.getFunctions())
                .flags(new ArrayList<>())
                .build();
        ingredient = ingredientRepository.save(ingredient);
        addFlags(ingredient, request.getFlags());
        return toDetail(ingredientRepository.save(ingredient));
    }

    @Transactional
    public IngredientDetail update(Long id, IngredientCreateRequest request) {
        Ingredient ingredient = ingredientRepository.findById(id)
                .orElseThrow(() -> new AppException("Ingredient not found", HttpStatus.NOT_FOUND));

        if (request.getCommonName() != null) ingredient.setCommonName(request.getCommonName());
        if (request.getDescription() != null) ingredient.setDescription(request.getDescription());
        if (request.getFunctions() != null) ingredient.setFunctions(request.getFunctions());

        if (request.getFlags() != null) {
            ingredient.getFlags().clear();
            addFlags(ingredient, request.getFlags());
        }
        return toDetail(ingredientRepository.save(ingredient));
    }

    private void addFlags(Ingredient ingredient, List<IngredientCreateRequest.FlagInput> flagInputs) {
        if (flagInputs == null) return;
        for (var fi : flagInputs) {
            ingredient.getFlags().add(IngredientFlag.builder()
                    .ingredient(ingredient)
                    .skinType(fi.getSkinType())
                    .flag(fi.getFlag())
                    .build());
        }
    }

    public IngredientDetail toDetail(Ingredient i) {
        IngredientDetail d = new IngredientDetail();
        d.setId(i.getId());
        d.setInciName(i.getInciName());
        d.setCommonName(i.getCommonName());
        d.setDescription(i.getDescription());
        d.setFunctions(i.getFunctions());
        d.setFlags(i.getFlags().stream().map(f -> {
            IngredientDetail.FlagSummary fs = new IngredientDetail.FlagSummary();
            fs.setSkinType(f.getSkinType());
            fs.setFlag(f.getFlag());
            return fs;
        }).toList());
        return d;
    }
}
