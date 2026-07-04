/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package test;

/**
 *
 * @author perer
 */
import dao.RecipeDAO;
import model.Recipe;
import java.util.List;


public class RecipeTest {
    public static void main(String[] args) {

        RecipeDAO recipeDAO = new RecipeDAO();

        if (recipeDAO.deleteRecipe(1)) {
            System.out.println("Recipe deleted successfully!");
        } else {
            System.out.println("Delete failed!");
        }
    }
}
