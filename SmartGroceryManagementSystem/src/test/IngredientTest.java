/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package test;

/**
 *
 * @author perer
 */
import dao.IngredientDAO;
import model.Ingredient;
import java.util.List;

public class IngredientTest {
    public static void main(String[] args) {

        IngredientDAO dao = new IngredientDAO();

if (dao.deleteIngredient(1)) {
    System.out.println("Ingredient deleted successfully!");
} else {
    System.out.println("Delete failed!");
}
    }
}
