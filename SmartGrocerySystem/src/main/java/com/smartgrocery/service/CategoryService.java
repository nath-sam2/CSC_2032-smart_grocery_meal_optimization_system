package com.smartgrocery.service;

import com.smartgrocery.dao.CategoryDAO;
import com.smartgrocery.model.Category;
import com.smartgrocery.util.IDGenerator;
import java.util.List;

public class CategoryService {

    private CategoryDAO categoryDAO = new CategoryDAO();

    public boolean addCategory(String name, String description) {
        int id = IDGenerator.generateId("categories");
        Category c = new Category(id, name, description);
        return categoryDAO.insertCategory(c);
    }

    public List<Category> getAllCategories() {
        return categoryDAO.getAllCategories();
    }

    public Category getCategoryById(int categoryId) {
        return categoryDAO.getCategoryById(categoryId);
    }

    public boolean updateCategory(int categoryId, String newName,
                                  String newDescription) {
        Category c = new Category(categoryId, newName, newDescription);
        return categoryDAO.updateCategory(c);
    }

    public boolean deleteCategory(int categoryId) {
        return categoryDAO.deleteCategory(categoryId);
    }
}