/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package test;

/**
 *
 * @author perer
 */
import dao.ShoppingListDAO;
import model.ShoppingList;
import java.time.LocalDate;

public class ShoppingListTest {
    public static void main(String[] args) {

        ShoppingListDAO dao = new ShoppingListDAO();

        ShoppingList list = new ShoppingList();

        list.setUserId(1);              // Existing user ID
        list.setCreatedDate(LocalDate.now());
        list.setStatus("Pending");

        if (dao.insertShoppingList(list)) {
            System.out.println("Shopping List inserted successfully!");
        } else {
            System.out.println("Insert failed!");
        }
    }
}
